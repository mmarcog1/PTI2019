defmodule PrototypeWeb.SessionController do
    use PrototypeWeb, :controller

    alias Prototype.Accounts

    def new(conn, _) do
        render(conn, "new.html")
    end

    def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
        case Accounts.authenticate_by_email_password(email, password) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Welcome #{user.name}")
                |> put_session(:user_id, user.id)
                |> configure_session(renew: true)
                |> redirect(to: Routes.user_path(conn, :show, user.id))
            {:error, :unauthorized} ->
                conn
                |> put_flash(:error, "Bad email/password combination")
                |> redirect(to: Routes.session_path(conn, :new))
            {:error, :not_found} ->
                conn
                |> put_flash(:error, "Account not found")
                |> redirect(to: Routes.session_path(conn, :new))
        end
    end

    def delete(conn, _) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: "/")
        |> put_flash(:success, "Successsfuly signed out")
    end
end
