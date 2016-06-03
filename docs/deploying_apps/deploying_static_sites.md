Create `index.html`:

```
$ touch index.html
```

Add some markup:

```html
<html>
  <head>
    <title>Static Site</title>
  </head>
  <body>
    <p>Welcome to the static site!</p>
  </body>
</html>
```

Create a `manifest.yml` that uses the [`staticfile_buildpack`](https://github.com/cloudfoundry/staticfile-buildpack):

```yml
---
applications:
- name: my-static-site
  memory: 64M
  buildpack: staticfile_buildpack
```

If the static content is included in a different folder, you can add a `path` declaration. E.g., `path: dist` or `path: assets`.

Deploy:

```
$ cf push
```


