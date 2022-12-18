#!/bin/sh

#
# Creates a Maven settings file for deploying the Maven site during CI.
#
# -- PARAMETERS --
#
# - $1: string, username for the deployment server
# - $2: string, password for the deployment server
# - $3: string, full URL where the site will be deployed
# - $4: string, Maven id for the site deployment server
#
# -- OUTPUT --
#
# - Maven settings file at site_settings.xml
#

# Fails if any commands returns a non-zero value
set -e

# Read input parameters
user=${1}
password=${2}
site_url=${3}
site_id=${4}
settings_file_name=${5}

# Define file path
settings_path=${settings_file_name}

# The contents of the file are created
{
   echo "<settings>";

   # ----------------
   # Servers settings
   # ----------------

   echo "<servers>";

   # Release site server
      echo "<server>";
         echo "<id>${site_id}</id>";
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
            echo "<site.url>${site_url}</site.url>"
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
