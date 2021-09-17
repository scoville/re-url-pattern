## URLPattern (`re-url-pattern`)

ReScript bindings for the incoming official [URLPattern](https://wicg.github.io/urlpattern/) class.

If you want to know more and see some examples of how the `URLPattern` class works you can take a look at this in-depth [blog post](https://web.dev/urlpattern/).

### Installation

You can install this module just like any other NPM git module and add `re-url-pattern` to the dependencies field in your `bsconfig.json` file.

_You will also need to install `urlpattern-polyfill` if the environment your code runs in doesn't support the `URLPattern` class yet._

### Simple usage

_You can find more examples [here](./example/index.res)._

The `URLPattern` module is meant to be as idiomatic and simple as possible to use.

Built from string (à la Express):

```rescript
let baseUrl = "https://example.com"

let pattern = URLPattern.fromString("/post/:id", ~baseUrl, ())

let match = pattern->URLPattern.exec("https://example.com/post/rescript-in-2022")

switch match {
| None => Js.log("No match, I shouldn't be displayed")
| Some({pathname}) => Js.log(`Got a match: ${pathname.groups->Js.Dict.unsafeGet("id")}`)
}
```

The `URLPattern` class is much more powerful though, you can extract the query parameters, the domain, or even the username/password:

```rescript
let pattern = URLPattern.make(
  URLPattern.init(
    ~protocol="https",
    ~username=":username",
    ~password=":password",
    ~hostname="example.:extension",
    ~pathname="/foo/*.:filetype(jpg|png)",
    ~search="?width=:width&ratio=:ratio",
    (),
  ),
)

let match =
  pattern->URLPattern.exec("https://admin:secret@example.fr/foo/chaton.png?width=200px&ratio=1%2F2")

switch match {
| None => Js.log("No match, I shouldn't be displayed")
| Some({username, password, pathname, hostname, search}) =>
  Js.log(
    `Username: ${username.groups->Js.Dict.unsafeGet("username")}
Password: ${password.groups->Js.Dict.unsafeGet("password")}
Host extension: ${hostname.groups->Js.Dict.unsafeGet("extension")}
Image extension: ${pathname.groups->Js.Dict.unsafeGet("filetype")}
Image width: ${search.groups->Js.Dict.unsafeGet("width")}
Image ratio: ${search.groups->Js.Dict.unsafeGet("ratio")->Js.Global.decodeURIComponent}`,
  )
}
```

Will display:

```
Username: admin
Password: secret
Host extension: fr
Image extension: png
Image width: 200px
Image ratio: 1/2
```
