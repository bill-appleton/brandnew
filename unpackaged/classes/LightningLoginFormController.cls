public class LightningLoginFormController {

    /** 
     * @description Constructor for LightningLoginFormController
     */
    public LightningLoginFormController() {
        // Constructor intentionally left empty
    }

    /**
     * @description Attempts to log in a user with the provided credentials
     * @param username The username of the user
     * @param password The password of the user
     * @param startUrl The URL to redirect to after login
     * @return Null if successful, otherwise returns the error message
     */
    @AuraEnabled
    public static String login(String username, String password, String startUrl) {
        try {
            ApexPages.PageReference lgn = Site.login(username, password, startUrl);
            aura.redirect(lgn);
            return null;
        } catch (Exception ex) {
            return ex.getMessage();
        }
    }

    /**
     * @description Checks if username and password login is enabled
     * @return True if enabled, otherwise false
     */
    @AuraEnabled
    public static Boolean getIsUsernamePasswordEnabled() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getUsernamePasswordEnabled();
    }

    /**
     * @description Checks if self-registration is enabled
     * @return True if enabled, otherwise false
     */
    @AuraEnabled
    public static Boolean getIsSelfRegistrationEnabled() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getSelfRegistrationEnabled();
    }

    /**
     * @description Retrieves the self-registration URL if enabled
     * @return The self-registration URL or null if not enabled
     */
    @AuraEnabled
    public static String getSelfRegistrationUrl() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        if (authConfig.getSelfRegistrationEnabled()) {
            return authConfig.getSelfRegistrationUrl();
        }
        return null;
    }

    /**
     * @description Retrieves the forgot password URL
     * @return The forgot password URL
     */
    @AuraEnabled
    public static String getForgotPasswordUrl() {
        Auth.AuthConfiguration authConfig = getAuthConfig();
        return authConfig.getForgotPasswordUrl();
    }

    /**
     * @description Retrieves the authentication configuration
     * @return The authentication configuration
     */
    @TestVisible
    private static Auth.AuthConfiguration getAuthConfig() {
        Id networkId = Network.getNetworkId();
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(networkId, '');
        return authConfig;
    }

    /**
     * @description Sets the experience ID for the site
     * @param expId The experience ID to set
     * @return Null if successful, otherwise returns the error message
     */
    @AuraEnabled
    public static String setExperienceId(String expId) {
        try {
            if (expId != null) {
                Site.setExperienceId(expId);
            }
            return null;
        } catch (Exception ex) {
            return ex.getMessage();
        }
    }
}

