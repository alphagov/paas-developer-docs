## Terminology
For terminology that is used within PaaS start with [Cloud Foundry’s glossary](http://docs.cloudfoundry.org/concepts/glossary.html).

## Organisations
Cloud Foundry groups its users by [organisations](http://docs.cloudfoundry.org/concepts/roles.html#orgs), or "orgs" for short. Orgs group together users for management and present a shared perimeter for services, domains and quotas. When your account is created, it will be given permissions to an org and a personal space.

### List available orgs
```
cf orgs
```

Only orgs where you've been assigned an org-role or those which contain a space where you've been assigned a space-role will appear.

### See details about a specific org
...including quotas, routing domains and which spaces it includes:

```
cf org ORGNAME
```

### Target an org
In order to work with spaces, you'll need to do this first:

```
cf target -o ORGNAME
```

## Spaces
Every application is scoped to a [space](http://docs.cloudfoundry.org/concepts/roles.html#spaces). Applications in the same space share a location for app development, deployment, and maintenance.

### Management
To create a space:

```
cf create-space SPACENAME
```

**Note:**  To create a space within a given org you must have the `OrgManager` role. You can check to see which users and managers for your org with:

```
cf org-users ORGNAME
```

## Target
The Cloud Foundry CLI keeps a global state of whatever [organisation](#organisations)+[space](#spaces) you're interacting with. This is known as the "target", and is set via

```
cf target -o ORGNAME -s SPACENAME
```

## Buildpacks
All apps need to use a 'buildpack' specific to their language, which sets up dependencies for particular language stacks. There are standard buildpacks for most languages, and they will usually be auto-detected by CF.