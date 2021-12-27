#!/bin/sh
#
# Function for creating the Maven settings file for the CI process, storing it in the
# ~/settings.xml path.
#
# It will take care of two pieces of data:
# - Servers settings
# - Active profile
#
# Server settings will be read by Maven from the environmental variables, and this
# file will tell him so.
#
# The active profile will depend on the type of version the current code is for.
# Depending on if this is a release or a development version.
#
# REMEMBER: For security reasons the data stored in the generated file should not be
# shared. Never print it on the console or let it be accessed in any way.
#
# --- SERVERS ---
#
# A total of four servers will be set:
# - releases: for deploying release artifacts
# - site: for deploying the Maven site for the release version
# - snapshots: for deploying snapshot artifacts
# - site-development: for deploying the Maven site for the development version
#
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script:
#
# - SITE_ID: string, id for the server site used
# - USER: string, user for the development repo
# - PASSWORD: string, password for the releases repo
# - SITE_URL: string, deployment URL
#

# Fails if any commands returns a non-zero value
set -e

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
         echo "<id>${SITE_ID}</id>";
         echo "<username>${USER}</username>";
         echo "<password>${PASSWORD}</password>";
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
            echo "<site.url>${SITE_URL}</site.url>"
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
