main-> app.NewControllerManagerCommand *cobra.Command

kubernetes/cmd/kube-controller-manager/app/controllermanager.go:
NewControllerManagerCommand-> options.NewKubeControllerManagerOptions()
                           -> &cobra.Command{}
                           -> Run() ->run()->CreateControllerContext(...)
                                                   ->informers.NewSharedInformerFactory(versionedClient, ResyncPeriod(s)())
                           ->  NewControllerInitializers(loopMode ControllerLoopMode) map[string]InitFunc
                           ->  StartControllers(ctx ControllerContext, startSATokenController InitFunc, controllers map[string]InitFunc, unsecuredMux *mux.PathRecorderMux) error

k8s.io/client-go/informers/factory.go
NewSharedInformerFactory ->NewSharedInformerFactoryWithOptions

kubernetes/pkg/controller/deployment/deployment_controller.go:
NewDeploymentController(dInformer appsinformers.DeploymentInformer, rsInformer appsinformers.ReplicaSetInformer, podInformer coreinformers.PodInformer, client clientset.Interface) (*DeploymentController, error)
(dc *DeploymentController) Run(workers int, stopCh <-chan struct{})
(dc *DeploymentController) worker()
    -> (dc *DeploymentController) processNextWorkItem() bool
           -> dc.syncHandler(key.(string)) == (dc *DeploymentController) syncDeployment(key string)
                    -> cache.SplitMetaNamespaceKey(key)
                    -> (dc *DeploymentController) getDeploymentsForReplicaSet(rs *apps.ReplicaSet) []*apps.Deployment
                    -> (dc *DeploymentController) getPodMapForDeployment(d *apps.Deployment, rsList []*apps.ReplicaSet) (map[types.UID][]*v1.Pod, error)
kubernetes/pkg/controller/deployment/sync.go
    -> (dc *DeploymentController) checkPausedConditions(d *apps.Deployment)
kubernetes/pkg/controller/deployment/recreate.go
    -> (dc *DeploymentController) rolloutRecreate(d *apps.Deployment, rsList []*apps.ReplicaSet, podMap map[types.UID][]*v1.Pod) error
kubernetes/pkg/controller/deployment/rolling.go
    -> (dc *DeploymentController) rolloutRolling(d *apps.Deployment, rsList []*apps.ReplicaSet) error
k8s.io/client-go/tools/cache
    -> cache.WaitForNamedCacheSync("deployment", stopCh, dc.dListerSynced, dc.rsListerSynced, dc.podListerSynced)

