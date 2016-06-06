This section explains how to create and deploy a static HTML page. It's
worth testing that you can carry out this process before you try to deploy a dynamic app.

Create `index.html`:

``
$ touch index.html
``

Add some markup to the `index.html` file:

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

Create a `manifest.yml` which uses the [`staticfile_buildpack`](https://github.com/cloudfoundry/staticfile-buildpack):

```yml
---
applications:
- name: my-static-site
  memory: 64M
  buildpack: staticfile_buildpack
```

If the static content is included in a different folder, you can add a `path` declaration, e.g. `path: dist` or `path: assets`.

From the directory where the `manifest.yml` file is:

``
cf push
``


