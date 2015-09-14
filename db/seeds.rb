
admin = User.create(username: 'admin', email: 'carlos.renck@zeta.com', password: 'admin', token:'3c897fa3098770eef3ed71e314d4c2b1')
zeta = Organization.create(name: 'Zeta Informática', owner_id: admin.id)
zeta_admin = Membership.create(organization:zeta, user:admin)

middleware = ServiceType.create(code: 'middleware', name: 'Zeta Middleware', description: 'O Middleware API da Zeta torna possível a integração entre nossas novas soluções para web e mobile e a versão desktop de nosso ERP.')
v1 = Service.create(version: 'v1', type_id: middleware.id)

ServiceInstance.create(service: v1, organization: zeta, url:'http://zetainfo.dyndns.info')

dash = Application.create(code: 'dash', name: 'Zeta Dashboards', description: 'Aplicação de dashboards da Zeta')
dash_v1 = ApplicationInstance.create(version: 'v1.0.0', url: 'http://hidden-wave-6476.herokuapp.com', application: dash)
zeta.application_instances << dash_v1
zeta.save

Authorization.create(application_instance_id: dash_v1.id, membership_id: zeta_admin.id)
