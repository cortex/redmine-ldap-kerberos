require 'krb5_auth'
include Krb5Auth

module AuthSourceLdapPatch
  def self.included(base)
    base.class_eval do
      def authenticate(login, password)
        return nil if login.blank? || password.blank?
        attrs = get_user_dn(login)
        logger.debug "Attempting kerberos authentication for '#{login}'"
        krb5 = Krb5.new
        if attrs && attrs[:dn] && krb5.get_init_creds_password(login, password)
          logger.debug "Authentication successful for '#{login}'" if logger && logger.debug?
          return attrs.except(:dn)
        end
        rescue  Net::LDAP::LdapError => text
          raise "LdapError: " + text
        rescue Krb5Auth::Krb5::Exception => error
          if error.message == "Decrypt integrity check failed"
            logger.debug "Incorrect password for #{login}"
            return nil
          else
            raise error
          end
      end
    end
  end
end

AuthSourceLdap.send(:include, AuthSourceLdapPatch)
