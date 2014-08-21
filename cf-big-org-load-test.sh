#!/bin/bash

cf api api.a1.cf-app.com --skip-ssl-validation
cf login -u admin -p sk1N875job -o go-76995182 -s go-space1

appPath=/Users/pivotal/workspace/projects/hello-sinatra
service=dummy
plan=small

for i in `seq 0 30`;
do
  cf create-space "dev-space-$i"
done

for space in `cf spaces | grep -E "^dev-space"`;
do
  cf target -s $space
  numApps=`jot -r 1 0 9`
  for i in `seq 0 $numApps`;
  do
    if [[ `jot -r 1 0 5` != "1" ]]
      then start="--no-start"
    else start=""
    fi
    cf push "dev-app-$i-in-$space" -p $appPath  -m 24MB $start
    if [[ `jot -r 1 0 4` != "1" ]]
      then cf create-service $service $plan "service-$i-in-$space"
    else cf create-user-provided-service "service-$i-in-$space"
    fi
  done
  for app in `cf apps | grep -o -E "^dev-app-.-in-dev-space-.*"`;
  do
    if [[ `jot -r 1 0 4` != "1" ]]; then
      serviceNum=`jot -r 1 0 9`
      cf bind-service $app "service-$serviceNum-in-$space"
    fi
  done
done


# permissions
# cf login -u admin -p admin
# cf target -o -large-org
# cf set-org-role dreinhold@pivotallabs.com heavy-org OrgManager
# cf set-org-role admin heavy-org OrgManager

# for space in `cf spaces | grep -E "^dev-space"`;
# do
  # yes yes | cf delete-space $space
  # cf target -s $space

  # cf set-space-role dreinhold@pivotallabs.com heavy-org $space SpaceDeveloper
  # cf set-space-role dreinhold@pivotallabs.com heavy-org $space SpaceManager
# done
