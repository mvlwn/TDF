set :deploy_to, '/my/path'
set :branch, 'master'

server 'www.example.org',
       user: 'username',
       roles: %w{web app db},
       ssh_options: {
         user: 'username',
         forward_agent: true,
         auth_methods: %w(password),
         password: 'my-secret-password'
       }
