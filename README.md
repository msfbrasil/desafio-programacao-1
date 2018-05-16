# Desafio de Programação

## Informações iniciais

Essa aplicação foi construída utilizando-se ruby 2.3.1 e rails 5.2.0.

Algumas bibliotecas foram utilizadas para melhorar o aspecto geral da solução e prover algumas funcionalidades, como:

- Bootstrap: interface
- Omniauth: delegação de autenticação do Facebook, Twitter, etc.

Assim que a aplicação for executada, basta autenticar no sistema utilizando a rede social desejada e acessar o menu "Sale Records" que apresentará uma tela para upload do arquivo.

Alguns exemplos de arquivos com informações inválidas ou quantidade de colunas errada, etc, podem ser encontrados na pasta test/resources.

## Dependencias

Uma das validações que achei relevante realizar antes do processamento do arquivo foi a validação do "MIME type". Para isso, foi utilizada a biblioteca "ruby-filemagic" que, por sua vez, exigiu a instalação do pacote de dependência abaixo:

$ sudo apt-get install libmagic-dev

Essa aplicação precisa ser iniciada com suporte a SSL, o que se tornou obrigatório no processo de delegação de autenticação do Facebook.\
Por conta disso, o pacote openssl precisa ser instalado através dos seguintes comandos:

**Importante**:\
Encontrei instruções que recomendavam a desinstalação do "puma" ("gem uninstall puma") antes de instalar os pacotes do SSL, e reinstalação ("gem install puma") em seguida. Como eu segui esses passos, eu não sei dizer se realmente são necessários e se a sequencia precisa ser: 1- Desinstalação do "puma"; 2- Instalação dos pacotes SSL; e, 3- Reinstalação do "puma".\
Caso tenha problemas em iniciar o servidor como será apresentado em seguida, mesmo após instalar os pacotes SSL, tente desinstalar e reinstalar o "puma".

$ sudo apt-get install openssl\
$ sudo apt-get install libssl-dev

## Configurações de delegação de autenticação (OAuth)

No arquivo de inicialização do Omniauth, encontrado na pasta config/initializers/omniauth.rb, são utilizadas variáveis de ambiente para informar os pares de chave "key" e segredo "secret" que identificam as aplicações de autenticação registradas no Facebook e no Twitter.

Para que a autenticação funcione, serão necessários os seguintes passos:

1- Crie o arquivo "config/application.yml", utilizado pelo "figaro" para gerenciar variáveis de ambiente, copiando o arquivo "config/application.yml.sample".\
2- Substitua as variáveis do arquivo "config/application.yml" por chaves e segredos válidos de aplicações funcionais do Facebook e Twitter.

A criação de aplicações para delegação de autenticação no Facebook e Twitter é explicada com detalhes no site "https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/".

Os passos para criação da aplicação Facebook não estão tão atualizados, mas seguem abaixo:

1. Acesse: https://developers.facebook.com/.
2. Utilize a opção "Adicionar novo aplicativo" do menu "Meus Aplicativos" no canto superior direito.
3. Entre com um nome para a sua aplicação e o seu email de contato e clique em "Criar Identificação do Aplicativo".
4. Na lista de produtos para adição, clique no botão "Configurar" do produto "Login do Facebook".
5. A próxima tela pergunta a plataforma dessa aplicação. Escolha "www" ou "Web".
6. Informe a URL do site. No nosso caso https://localhost:3000/. Clique em salvar.
7. Desconsidere as outras abas da configuração inicial e acesse a opção "Configurações\Básico" do lado esquerdo da tela.
8. Informe "localhost" no campo "Domínios do Aplicativo" e clique em "Salvar Alterações".
9. Clique no produto "Login do Facebook" (do lado esquerdo e mais abaixo), e acesse a opção "Configurações".
10. Informe "https://localhost:3000/auth/facebook/callback" no campo "URIs de redirecionamento do OAuth válidos" e clique em "Salvar Alterações".
11. Retorne à opção "Configurações\Básico" (no canto esquerdo e superior) e informe alguma URL válida no campo "URL da Política de Privacidade" e clique em "Salvar Alterações" (isso é necessário para o último passo que é a ativação da aplicação).
12. No topo da tela clique em "Desativado" para ativar a aplicação. Escolha uma categoria e cliente em "Confirmar".
13. Ufa... É isso aí. A sua aplicação deve estar pronta para uso!!!!! Basta você pegar a chave "key" no campo "ID do Aplicativo" e o segredo "secret" no campo "Chave Secreta do Aplicativo" acessando novamente a opção "Configurações\Básico" (no canto esquerdo e superior).

## Passos finais

Agora nós podemos executar os passos finais para subir a nossa aplicação através dos seguintes comandos:

$ bundle install

e

$ rake db:migrate

O diretório "tmp/uploads" é utilizado para armazenamento temporário dos arquivos a serem processados pela aplicação e deve, portanto, ser criado através do comando:

$ mkdir tmp/uploads

Finalmente, inicie o servidor através do comando abaixo: 

rails server -b 'ssl://localhost:3000?key=.ssl/localhost.key&cert=.ssl/localhost.crt'

## Observações:

1- Os seguintes testes unitários dos modelos e helpers foram disponibilizados:

$ rails test test/helpers/sale_record_file_parser_test.rb\
$ rails test test/models/user_test.rb\
$ rails test test/models/sale_record_test.rb

2- Testes dos controlers utilizando RSpec podem ser também executados através do comando abaixo:

$ rspec --order defined

3- Alguns exemplos de arquivos com informações inválidas ou quantidade de colunas errada, etc, podem ser encontrados na pasta test/resources. Alguns possuem extensões diferentes da esperada para que caiam na validação MIME.

ENJOY!


