defmodule Prototype.Auth do
    import Plug.Conn
    import Phoenix.Controller
    alias PrototypeWeb.Router.Helpers
    alias PrototypeWeb.ErrorView

    def init(opts), do: opts

    def call(conn, _opts) do
        user_id = get_session(conn, :user_id)
        user = user_id && Prototype.Accounts.get_user!(user_id)
        put_current_user(conn, user)
    end

    def logged_in_user(conn = %{assigns: %{current_user: %{}}}, _), do: conn
    
    def logged_in_user(conn, _opts) do
        conn
        |> put_flash(:error, "You must be logged in to access the reports")
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt()
    end

    def admin_user(conn = %{assigns: %{admin_user: true}}, _), do: conn

    def admin_user(conn, opts) do
        if opts[:pokerface] do
            conn
            |> put_status(404)
            |> render(ErrorView, :"404", message: "Page not found")
            |> halt()
        end
        conn
        |> put_flash(:error, "You do not have access to that")
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt()

    end
    defp put_current_user(conn, user) do
        conn
        |> assign(:current_user, user)
        |> assign(:admin_user, !!user && !!user.credential && user.credential.email == "mmarcog1@outlook.com")
    end
end