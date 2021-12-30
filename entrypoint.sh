#!/bin/sh

# Fails if any commands returns a non-zero value
set -e

siteId=${1}
siteUrl=${2}
user=${3}
password=${4}

settings_path="site_settings.xml"

# The contents of the file are created
{
   echo "<settings>";

   # ----------------
   # Servers settings
   # ----------------

   echo "<servers>";

   # Release site server
      echo "<server>";
         echo "<id>${siteId}</id>";
         echo "<username>${user}</username>";
         echo "<password>${password}</password>";
         echo "<configuration>";
            echo "<strictHostKeyChecking>no</strictHostKeyChecking>";
            echo "<preferredAuthentications>publickey,password</preferredAuthentications>";
            echo "<interactive>false</interactive>";
         echo "</configuration>";
      echo "</server>";

   echo "</servers>";
   
   # --------
   # Profiles
   # --------
   
   echo "<profiles>";
   
      echo "<profile>";
         echo "<id>deployment_site</id>"
         # This profile is used to define the deployment site URL
         echo "<properties>"
            # Deployment site
            echo "<site.url>${siteUrl}</site.url>"
         echo "</properties>"
      echo "</profile>";

   echo "</profiles>";

   # --------------
   # Active profile
   # --------------

   # These profiles are used to set configuration specific to a version type
   echo "<activeProfiles>"
      echo "<activeProfile>deployment_site</activeProfile>"
   echo "</activeProfiles>"

   echo "</settings>";
} >> ${settings_path}

echo "Created Maven settings file at ${settings_path}"

exit 0
