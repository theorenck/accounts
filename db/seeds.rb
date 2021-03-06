
admin = User.create(username: 'administrator',
                    email: 'ivonei.marques@zeta.com.br',
                    password: 'administrator',
                    token:'3c897fa3098770eef3ed71e314d4c2b1',
                    active: true )

zeta = Organization.create(name: 'Zeta Informática', owner_id: admin.id)
zeta_admin = Membership.create(organization:zeta, user:admin, active: true)

middleware = ServiceType.create(code: 'middleware', name: 'Zeta Middleware', description: 'O Middleware API da Zeta torna possível a integração entre nossas novas soluções para web e mobile e a versão desktop de nosso ERP.')
v1 = Service.create(version: 'v1', type_id: middleware.id)

ServiceInstance.create(service: v1, organization: zeta, uri:'http://localhost:9292')

dash_v1 = Application.create(version: 'v1.0.0',
  redirect_uri: 'http://hidden-wave-6476.herokuapp.com',
  name: 'Zeta Dashboards',
  description: 'Aplicação de dashboards da Zeta',
  scopes: ['user', 'admin'])

zeta.applications << dash_v1
zeta.save

Authorization.create(application_id: dash_v1.id, membership_id: zeta_admin.id, scopes: ['admin'])
