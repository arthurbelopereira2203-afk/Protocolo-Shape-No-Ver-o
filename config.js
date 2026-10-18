// CONFIGURAÇÃO DO APP: preencha os campos abaixo e salve.
window.APP_CONFIG = {
  // Supabase: painel > Project Settings > API
  supabaseUrl: "https://xspphatjtqorlhyjpwsf.supabase.co",          // ex.: https://abcdxyz.supabase.co
  supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhzcHBoYXRqdHFvcmxoeWpwd3NmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIzNDYyOTgsImV4cCI6MjEwNzkyMjI5OH0.s1Vodqz8dYZ_BMVysPArZ6GWAlmnR7S_RMpHPsDZ7_Y",  // chave "anon public" (NUNCA use a service_role aqui)

  // Link da página de vendas do protocolo na Kiwify (aparece para quem tenta entrar sem ter comprado). Opcional.
  buyUrl: "",

  // Links de checkout da Kiwify dos produtos da loja, NESTA ORDEM:
  // 1) Kit de faixas elásticas  2) Garrafa de 2 litros  3) Tapete de exercícios  4) E-book de receitas
  // Deixe "" nos que ainda não existem: o botão mostra "A venda abre em breve".
  links: ["", "", "", ""]
};
