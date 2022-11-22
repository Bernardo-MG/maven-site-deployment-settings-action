# Maven Site Deployment Settings Action

Creates a Maven settings file for deploying Maven sites. This will be available at ~/site_settings.xml path, and will include only the necessary info for deploying the site.

REMEMBER: For security reasons the data stored in the settings file should not be shared. Never print it on the console or let it be accessed in any way.

## Inputs

| Input    | Description                                                                                            | Required                  |
|----------|--------------------------------------------------------------------------------------------------------|---------------------------|
| siteId   | Id of the server used for deploying the site. This will be a server define in the Maven configuration. | False, defaults to 'site' |
| siteUrl  | URL for deploying the site.                                                                            | True                      |
| username | Username for the site server.                                                                          | True                      |
| password | Password for the site server.                                                                          | True                      |

## Usage

This builds the site settings from the Github secrets and then deploy the Maven site.

```
jobs:
  deploy:
    name: Deployment
    runs-on: ubuntu-latest

    steps:
    - name: Check-out
      uses: actions/checkout@v2
    - name: Set up JDK
      uses: actions/setup-java@v2
      with:
        java-version: 11
        distribution: 'adopt'
        cache: 'maven'
    - name: Set up Maven settings for site deployment
      uses: bernardo-mg/maven-site-deployment-settings-action@v1
      with:
        siteId: site
        siteUrl: ${{ secrets.url }}
        username: ${{ secrets.username }}
        password: ${{ secrets.password }}
    - name: Generate docs
      run: mvn verify site -B -P deployment-site
    - name: Deploy docs
      run: mvn site:deploy -B -P deployment-site -DskipTests --settings site_settings.xml
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
