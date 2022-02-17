docker build -t anthonycastellano/multi-client:latest -t anthonycastellano/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anthonycastellano/multi-server:latest -t anthonycastellano/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anthonycastellano/multi-worker:latest -t anthonycastellano/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anthonycastellano/multi-client:latest
docker push anthonycastellano/multi-server:latest
docker push anthonycastellano/multi-worker:latest

docker push anthonycastellano/multi-client:$SHA
docker push anthonycastellano/multi-server:$SHA
docker push anthonycastellano/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anthonycastellano/multi-server:$SHA
kubectl set image deployments/client-deployment client=anthonycastellano/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anthonycastellano/multi-worker:$SHA