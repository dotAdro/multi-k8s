docker build -t dotadro/multi-client:latest -t dotadro/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t dotadro/multi-server:latest -t dotadro/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t dotadro/multi-worker:latest -t dotadro/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push dotadro/multi.client:latest
docker push dotadro/multi.server:latest
docker push dotadro/multi.worker:latest

docker push dotadro/multi.client:$GIT_SHA
docker push dotadro/multi.server:$GIT_SHA
docker push dotadro/multi.worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dotadro/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=dotadro/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=dotadro/multi-worker:$GIT_SHA
