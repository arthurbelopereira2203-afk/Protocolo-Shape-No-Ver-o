-- Rode este arquivo inteiro no Supabase: SQL Editor > New query > Run.

-- 1) Compradores (preenchida só pelo webhook da Kiwify, nunca pelo app)
create table if not exists public.purchases (
  email text primary key,
  status text not null default 'approved' check (status in ('approved','refunded')),
  order_id text,
  updated_at timestamptz not null default now()
);
alter table public.purchases enable row level security;  -- sem políticas: o app não lê nem grava aqui

-- 2) Progresso de cada cliente
create table if not exists public.progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.progress enable row level security;

-- 3) Funções de verificação de acesso
create or replace function public.email_has_access(p_email text)
returns boolean language sql security definer set search_path = public stable as $$
  select exists (select 1 from public.purchases
                 where email = lower(trim(p_email)) and status = 'approved');
$$;
revoke all on function public.email_has_access(text) from public;
grant execute on function public.email_has_access(text) to anon, authenticated;

create or replace function public.has_access()
returns boolean language sql security definer set search_path = public stable as $$
  select exists (select 1 from public.purchases
                 where email = lower(auth.jwt() ->> 'email') and status = 'approved');
$$;
revoke all on function public.has_access() from public;
grant execute on function public.has_access() to authenticated;

-- 4) Regras: cada cliente só enxerga e grava o PRÓPRIO progresso, e só com compra aprovada
drop policy if exists "progress_select_own" on public.progress;
drop policy if exists "progress_insert_own" on public.progress;
drop policy if exists "progress_update_own" on public.progress;
create policy "progress_select_own" on public.progress for select to authenticated
  using (user_id = auth.uid() and public.has_access());
create policy "progress_insert_own" on public.progress for insert to authenticated
  with check (user_id = auth.uid() and public.has_access());
create policy "progress_update_own" on public.progress for update to authenticated
  using (user_id = auth.uid() and public.has_access())
  with check (user_id = auth.uid() and public.has_access());
