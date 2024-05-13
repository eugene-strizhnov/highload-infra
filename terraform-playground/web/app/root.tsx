import {
    Form,
    NavLink,
    Links,
    Meta,
    Outlet,
    Scripts,
    ScrollRestoration,
    useLoaderData,
    useNavigation,
    useSubmit,
} from "@remix-run/react";
import {useEffect} from "react";
import {LinksFunction, LoaderFunctionArgs, json, redirect} from "@remix-run/node";

import appStylesHref from "./app.css?url";

export const links: LinksFunction = () => [
    {rel: "stylesheet", href: appStylesHref},
];

import {createEmptyContact, getContacts} from "./data";

export const loader = async ({request}: LoaderFunctionArgs) => {
    const url = new URL(request.url);
    const q = url.searchParams.get("q");
    const contacts = await getContacts(q);
    return json({contacts, q});
};

export const action = async () => {
    const contact = await createEmptyContact();
    return redirect(`/contacts/${contact.id}/edit`);
};

export default function App() {

    const {contacts, q} = useLoaderData<typeof loader>();
    const navigation = useNavigation();

    useEffect(() => {
        const searchField = document.getElementById("q");
        if (searchField instanceof HTMLInputElement) {
            searchField.value = q || "";
        }
    }, [q]);

    const submit = useSubmit();

    const searching =
        navigation.location &&
        new URLSearchParams(navigation.location.search).has("q");

    return (
        <html lang="en">
        <head>
            <meta charSet="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <Meta/>
            <Links/>
        </head>
        <body>
        <div id="sidebar">
            <h1>Remix Contacts</h1>
            <div>
                <Form
                    id="search-form"
                    role="search"
                    onChange={(event) => {
                        const isFirstSearch = q === null;
                        submit(event.currentTarget, {
                            replace: !isFirstSearch,
                        });
                    }}
                >
                    <input
                        id="q"
                        defaultValue={q || ""}
                        aria-label="Search contacts"
                        className={searching ? "loading" : ""}
                        placeholder="Search"
                        type="search"
                        name="q"
                    />
                    <div id="search-spinner" aria-hidden hidden={!searching}/>
                </Form>
                <Form method="post">
                    <button type="submit">New</button>
                </Form>
            </div>
            <nav>
                {contacts.length ? (
                    <ul>
                        {contacts.map((contact) => (
                            <li key={contact.id}>
                                <NavLink
                                    className={
                                        ({isActive, isPending}) =>
                                            isActive
                                                ? "active"
                                                : isPending
                                                    ? "pending"
                                                    : ""
                                    }
                                    to={`contacts/${contact.id}`}
                                >
                                    {contact.first || contact.last ? (
                                        <>
                                            {contact.first} {contact.last}
                                        </>
                                    ) : (
                                        <i>No Name</i>
                                    )}{" "}
                                    {contact.favorite ? (
                                        <span>★</span>
                                    ) : null}
                                </NavLink>
                            </li>
                        ))}
                    </ul>
                ) : (
                    <p>
                        <i>No contacts</i>
                    </p>
                )}
            </nav>
        </div>
        <div
            className={
                navigation.state === "loading" && !searching ? "loading" : ""
            }

            id="detail">
            <Outlet/>
        </div>
        <ScrollRestoration/>
        <Scripts/>
        </body>
        </html>
    );
}