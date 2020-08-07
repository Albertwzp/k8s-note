# Service Account & User
***
## diff between ua & sa
1. ua for user, sa for pod or service.
2. ua is global, sa isolation by ns.
3. ua is complex, sa is permission minimization.
4. diffrent audit for ua & sa.
5. ua is heavy weight, sa is light weight.

---
## SA automation
### 服务账户准入控制器(Service account admission controller)
> Part in api-server
a. if not set sa in pod, sa is default.
b. pod must related one sa, otherwise delete pod.
c. if ImagePullSecrets not in pod, else sa IPS addition pod?
d. token for api will addition pod.
f. /var/run/secrets/kubernetes.io/serviceaccount will mount in pod.

---
### Token 控制器(Token controller)
> Part in controller-manager
> --service-account-private-key-file transfer private-key to token controller for create token,
> --service-account-key-file transfer public-key to 
1. detect sa creation, create its secret.
2. detect sa deletion, delete its secret.
3. detect secret creation, check sa & add token if need.
4. detect secret deletion, remove from sa if need.

### 服务账户控制器(Service account controller)
