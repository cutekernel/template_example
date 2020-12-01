To Get started:

build the FIPS testing stack from  you host from the testing-nodes directory:
docker-compose up --build -d

tear down the stack
docker-compose down

test the stack
docker exec -it ttans0 sh -c "./ping.sh"


