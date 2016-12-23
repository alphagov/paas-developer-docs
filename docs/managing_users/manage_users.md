CloudFoundry contains user management functionality in order to organise user permissions and space/org membership, which determine what each individual users can do. This is detailed in [the Cloudfoundry documentation](https://docs.cloudfoundry.org/concepts/roles.html). We'll cover here the most common roles and configuration options and describe what that means for platform users.

## User roles

CF provides several roles user can assume. These are always defined in relation to an [organisation](../deploying_apps/orgs_spaces_targets.md#organisations) or [space](../deploying_apps/orgs_spaces_targets.md#spaces). A single user can have multiple roles in the same org/space and have different roles among different orgs and spaces.

### Space developer
This is the default role for a non manager user. Allows pushing, starting, stopping applications and creating and binding services. All within a given space.

### Space manager
The Space manager can manage users within a given space.

### Organisation manager
An organisation manager can create spaces and add/remove users to them. They are usually managers of a product, a team, a department. This means that the org manager has some duties regarding [user lifecycle](user_lifecycle.md).
The org manager is also the main contact for PaaS support and will decide on quota adjustment, enabling paid services, etc.
