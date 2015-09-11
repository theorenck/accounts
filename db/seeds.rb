
admin = User.create(username: 'admin', email: 'carlos.renck@zeta.com', password: 'admin', token:'3c897fa3098770eef3ed71e314d4c2b1')
zeta = Organization.create(name: 'Zeta Informática', owner_id: admin.id)
Membership.create(organization:zeta, user:admin)

middleware = ServiceType.create(code: 'middleware', name: 'Zeta Middleware', description: 'O Middleware API da Zeta torna possível a integração entre nossas novas soluções para web e mobile e a versão desktop de nosso ERP.')
v1 = Service.create(version: 'v1', type_id: middleware.id)

ServiceInstance.create(service: v1, organization: zeta, url:'http://zetainfo.dyndns.info')

