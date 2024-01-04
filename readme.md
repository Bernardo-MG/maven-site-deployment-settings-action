# Maven Site Deployment Settings Action

Creates a Maven settings file for deploying Maven sites. This will be available at ~/site_settings.xml path, and will include only the necessary info for deploying the site.

REMEMBER: For security reasons the data stored in the settings file should not be shared. Never print it on the console or let it be accessed in any way.

## Inputs

| Input    | Description                               | Required                  |
|----------|-------------------------------------------|---------------------------|
| username | Username for the deployment server.       | True                      |
| password | Password for the deployment server.       | True                      |
| siteUrl  | Full URL where the site will be deployed. | True                      |
| siteId   | Maven id for the site deployment server.  | False, defaults to 'site' |

## Usage

This builds the site settings from the Github secrets and then deploy the Maven site.

```yaml
jobs:
  deploy:
    name: Deployment
    runs-on: ubuntu-latest

    steps:
    - name: Check-out
      uses: actions/checkout@v4
    - name: Set up JDK
      uses: actions/setup-java@v4
      with:
        java-version: 17
        distribution: 'temurin'
        cache: 'maven'
    - name: Set up Maven settings for site deployment
      uses: bernardo-mg/maven-site-deployment-settings-action@v1
      with:
        username: ${{ secrets.username }}
        password: ${{ secrets.password }}
        siteUrl: ${{ secrets.url }}
    - name: Generate docs
      run: mvn verify site -B
    - name: Deploy docs
      run: mvn site:deploy -B -DskipTests --settings site_settings.xml
```

### Maven Site Configuration

The action won't works unless the Maven project includes a deployment site:

```yaml
<distributionManagement>
   <site>
      <id>site</id>
      <name>Project Documentation Site</name>
      <url>${site.url}</url>
   </site>
</distributionManagement>
```

This works because the default id is site, and the action will store the deployment URL into the site.url maven property.

The site id can be can be changed with the siteId parameter:

```yaml
jobs:
  deploy:
    name: Deployment
    runs-on: ubuntu-latest

    steps:
    - name: Set up Maven settings for site deployment
      uses: bernardo-mg/maven-site-deployment-settings-action@v1
      with:
        siteId: siteName
        username: ${{ secrets.username }}
        password: ${{ secrets.password }}
        siteUrl: ${{ secrets.url }}
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

[issues]: https://github.com/Bernardo-MG/maven-site-deployment-settings-action/issues
[license]: https://www.opensource.org/licenses/mit-license.php
[scm]: https://github.com/Bernardo-MG/maven-site-deployment-settings-action
