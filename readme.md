# Maven Site Deployment Settings Action

Creates a Maven settings file for deploying Maven sites. This will be available at ~/site_settings.xml path, and will include only the necessary info for deploying the site.

REMEMBER: For security reasons the data stored in the settings file should not be shared. Never print it on the console or let it be accessed in any way.

## Inputs

| Input    | Description                                                                                            | Required                  |
|----------|--------------------------------------------------------------------------------------------------------|---------------------------|
| siteId   | Id of the server used for deploying the site. This will be a server define in the Maven configuration. | False, defaults to 'site' |
| siteUrl  | URL for deploying the site.                                                                            | True                      |
| user     | Username for the site server.                                                                          | True                      |
| password | Password for the site server.                                                                          | True                      |

## Usage

After receiving the parameters, a site-settings.xml will be created ready for deploying the Maven site.

```
steps:
- name: Set up Maven settings
  uses: bernardo-mg/maven-site-deployment-settings-action@v1
  env:
    siteId: site
    siteUrl: ${{ secrets.DEPLOY_DOCS_SITE }}
    user: ${{ secrets.DEPLOY_DOCS__USER }}
    password: ${{ secrets.DEPLOY_DOCS_PASSWORD }}
- name: Deploy development docs
  run: mvn verify site site:deploy -B --settings site-settings.xml
```

## Collaborate

Any kind of help with the project will be well received, and there are two main ways to give such help:

- Reporting errors and asking for extensions through the issues management
- or forking the repository and extending the project

### Issues management

Issues are managed at the GitHub [project issues tracker][issues], where any Github user may report bugs or ask for new features.

### Getting the code

If you wish to fork or modify the code, visit the [GitHub project page][scm], where the latest versions are always kept. Check the 'master' branch for the latest release, and the 'develop' for the current, and stable, development version.

## License
The project has been released under the [MIT License][license].

[issues]: https://github.com/Bernardo-MG/deployment-maven-settings-action/issues
[license]: http://www.opensource.org/licenses/mit-license.php
[scm]: http://github.com/Bernardo-MG/deployment-maven-settings-action
