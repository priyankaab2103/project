# scanner.sh
export PASSWORD="secret"
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "login=admin" -d "password=$PASSWORD" -d "previousPassword=admin" -u admin:admin 127.0.0.1:9000/api/users/change_password
export SONAR_LOGIN=$(curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "name=admin" -u admin:admin 127.0.0.1:9000/api/user_tokens/generate | python3 -c "import sys, json; print(json.loads(sys.stdin)["token"])")
sonar-scanner -X -Dsonar.projectKey=project -Dsonar.sources=. -Dsonar.host.url=http://127.0.0.1:9000 -Dsonar.login=$SONAR_LOGIN