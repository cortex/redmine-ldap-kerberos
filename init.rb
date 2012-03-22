require 'redmine'

require_dependency 'auth_source_ldap_patch'

Redmine::Plugin.register :redmine_ldap_kerberos do
  name 'Redmine Ldap Kerberos plugin'
  author 'Joakim Lundborg'
  description 'Authenticate LDAP users with kerberos password'
  version '0.0.1'
  url 'https://github.com/cortex/redmine-ldap-kerberos'
  author_url 'https://github.com/cortex'
end
