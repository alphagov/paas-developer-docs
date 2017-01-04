The Government PaaS relies on the Cloud Foundry user management system to determine what each individual tenant user account can do.

Note that the "users" we're talking about here are members of your team who use the command-line tool to manage apps on the PaaS, **not** the end users of your apps.

In this section, we'll cover the most common roles and describe what they mean for how you use the PaaS.

For full details about the possible roles, see [the Cloud Foundry documentation](https://docs.cloudfoundry.org/concepts/roles.html).

## User roles

There are multiple **roles** that a user can have. These are always defined in relation to an [organisation](../deploying_apps/orgs_spaces_targets#organisations) or a [space](../deploying_apps/orgs_spaces_targets#spaces). A user can have different roles in different orgs or spaces. A user can have more than one role within the same org or space.


### Space Developer
This role applies within a particular space. 

A Space Developer can push, start and stop apps, and create and bind services. This is the default role for a user who is not a manager.

For example, suppose you have `testing` and `production` spaces. You choose to grant a new junior developer the Space Developer role in the `testing` space, but no role in the `production` space. As a result, the developer can change apps in `testing`, but cannot do anything in `production`.

### Space Manager
This role applies within a particular space. 

A Space Manager can add/remove users within the space, and change properties of the space, such as the name. Being a Space Manager does not grant the ability to change apps or services, so you would need to grant the Space Developer role as well if you want the user to be able to do both things.

For example, suppose you have a senior developer who manages junior developers who work in your `testing` space, and also needs to change apps in both `testing` and `production` spaces. You choose to grant the senior developer the Space Manager role in the `testing` space, and the Space Developer role in both `testing` and `production`. As a result, the developer can add users to `testing` but not to `production`, and can change apps in both spaces.

### Org Manager
This role applies within a particular organisation. Typically, your team will  only have one organisation within the Government PaaS, but you may have more than one.

An Org Manager can create/delete spaces and add/remove users. People with this role are likely to be managers of a product, team or department. This means that they have some duties regarding [user lifecycle](user_lifecycle.md). 

The Org Manager is also the main contact for Government PaaS support and will decide on quotas and enabling paid services.

If your account does not have the Org Manager role and you need to create a new space, you should ask a co-worker who is an Org Manager for your organisation. If you need the Org Manager role to be added to a user account, contact us at [gov-uk-paas-support@digital.cabinet-office.gov.uk](mailto:gov-uk-paas-support@digital.cabinet-office.gov.uk).
