let baseUrl = "https://example.com"

let pattern = URLPattern.fromString("/post/:id", ~baseUrl, ())

let match = pattern->URLPattern.exec("https://example.com/post/rescript-in-2022")

switch match {
| None => Js.log("No match, I shouldn't be displayed")
| Some({pathname}) => Js.log(`Got a match: ${pathname.groups->Js.Dict.unsafeGet("id")}`)
}

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

let pattern = URLPattern.fromString("https://*.example.com/foo/*", ())

let match = pattern->URLPattern.exec("https://foo.example.com/foo/bar")

switch match {
| None => Js.log("no luck")
| Some({pathname, hostname}) =>
  Js.log(pathname.groups)
  Js.log(hostname.groups)
}

let pattern = URLPattern.fromString("foo/*", ~baseUrl="https://*.example.com/", ())

let match = pattern->URLPattern.exec("https://foo.example.com/foo/bar")

switch match {
| None => Js.log("no luck")
| Some({pathname, hostname}) =>
  Js.log(pathname.groups)
  Js.log(hostname.groups)
}

let pattern = URLPattern.make(
  URLPattern.init(~pathname="/something", ~search="?mode=:mode&id=:id", ()),
)

let match =
  pattern->URLPattern.exec(
    "http://localhost/something?mode=show&id=f3012bf4-b873-453b-bf53-27c067b1230d",
  )

switch match {
| None => Js.log("no luck")
| Some({search}) => Js.log(search.groups)
}

let match =
  pattern->URLPattern.exec(
    "http://localhost/something?mode=show&idd=f3012bf4-b873-453b-bf53-27c067b1230d",
  )

switch match {
| None => Js.log("no luck")
| Some({search}) => Js.log(search.groups)
}
