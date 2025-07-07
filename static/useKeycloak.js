import Keycloak from "keycloak-js";

export const useKeycloak = (onInit, onAuthStateUpdated) => {
    let user = {};

    const keycloak = new Keycloak({
        url: "http://localhost:1236",
        realm: "elm-realm",
        clientId: "keycloak-elm-client",
    });

    const getValueFromToken = (key) =>
        keycloak.tokenParsed ? keycloak.tokenParsed[key] : "";

    const getAuthState = () => ({
        authenticated: keycloak.authenticated || false,
        token: keycloak.token || "",
        userName: getValueFromToken("preferred_username"),
        email: getValueFromToken("email"),
    });

    keycloak.onAuthSuccess = () => {
        onAuthStateUpdated(getAuthState());
    }

    keycloak.onAuthError = () => {
        onAuthStateUpdated(getAuthState());
        clearInterval(tokenRefreshInterval);
    }

    keycloak.onAuthRefreshSuccess = () => {
        onAuthStateUpdated(getAuthState());
    }

    keycloak.onAuthRefreshError = () => {
        onAuthStateUpdated(getAuthState());
        clearInterval(tokenRefreshInterval);
    }

    const tokenRefreshInterval = setInterval(() => {
        console.log("token refresh");
        if (keycloak.didInitialize && keycloak.authenticated) {
            keycloak.updateToken();
        }
    }, 60 * 1000);

    keycloak.init({ onLoad: "check-sso", checkLoginIframe: false }).then(onInit(getAuthState()));

    return {
        login: keycloak.login,
        logount: keycloak.logout
    }
}
