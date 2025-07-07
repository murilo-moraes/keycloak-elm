import { useKeycloak } from "../static/useKeycloak"


export const onReady = ({ app, env }) => {
    const { login, logout } = useKeycloak(
        (authState) => {
            app.ports.authStateUpdated.send(authState);
        },
        (authState) => {
            app.ports.authStateUpdated.send(authState);
        }
    );

    if (app.ports && app.ports.outgoing) {
        app.ports.outgoing.subscribe(({ tag, data }) => {
            switch (tag) {
                case "LOGIN":
                    login();
                    return;

                case "LOGOUT":
                    logout();
                    return;
            }
        })
    }
}