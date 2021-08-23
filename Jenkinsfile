pipeline {
  agent any

  stages {

    stage('Checkout') {
      steps {
          checkout scm
      }
    }

    stage('Get clusterresources Stage') {
      steps {
        script{
          sh "kubectl api-resources --verbs=list --namespaced -o name | xargs -n1 -I{} bash -c \"kubectl get {} --all-namespaces -oyaml && echo ---\" > clusterresources.txt"
        }
      }
    }

    stage('Helm template Stage') {
      steps {
        script{
          sh "helm template familyapp k8s/familychart/ --values k8s/familychart/values.yaml > helmtemplate.txt"
        }
      }
    }

    stage ('Test stage') {

      parallel {

        stage ('Check Secrets Stage') {
          steps {
            script{
              try {
                sh "rm trufflehog.txt || true"
                sh 'docker run --rm --name trufflehog dxa4481/trufflehog --regex https://github.com/KieniL/FamilyCluster_Config.git > trufflehog.txt'
          
                publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'trufflehog.txt',
                  reportName: "Trufflehog Report"
                ])
              }catch (exc) {
                error('Check secret failed' + exc.message)
              }   
            }
          }
        }

        stage ('Kube-bench in cluster Stage') {
          steps {
            script {
              sh "kubectl apply -f k8s/security/kube-bench.yaml"
              sh "kubectl wait --for=condition=complete job/kube-bench"
              sh "kubectl logs -l job-name=kube-bench --tail -1 > kube-bench-in-cluster.txt"
              sh "kubectl delete job kube-bench"


              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-bench-in-cluster.txt',
                  reportName: "Kube Bench (in cluster) Report"
              ])
            }   
          }
        }

        stage ('Kube-hunter in cluster Stage') {
          steps {
            script {
              sh "kubectl apply -f k8s/security/kube-hunter.yaml"
              sh "kubectl wait --for=condition=complete job/kube-hunter"
              sh "kubectl logs -l job-name=kube-hunter --tail -1 > kube-hunter-in-cluster.txt"
              sh "kubectl delete job kube-hunter"

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-hunter-in-cluster.txt',
                  reportName: "Kube Hunter (in cluster) Report"
              ])
            } 
          }
        }


        stage ('Kube-hunter out of cluster Stage') {
          steps {
            script {
              try{
                sh "chmod +x kube-hunter.sh"
                sh "./kube-hunter.sh > kube-hunter-out-of-cluster.txt"
              }catch (exc) {} 
              

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-hunter-out-of-cluster.txt',
                  reportName: "Kube Hunter (out of cluster) Report"
              ])
            } 
          }
        }

        stage ('Kube-hunter active out of cluster Stage') {
          steps {
            script {
              try{
                sh "chmod +x kube-hunter-active.sh"
                sh "./kube-hunter-active.sh > kube-hunter-active-out-of-cluster.txt"
              }catch (exc) {} 
              

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-hunter-active-out-of-cluster.txt',
                  reportName: "Kube Hunter active (out of cluster) Report"
              ])
            } 
          }
        }


        stage ('Kube-bench out of cluster Stage') {
          steps {
            script {
              sh "chmod +x kube-bench.sh"
              sh "./kube-bench.sh > kube-bench-out-of-cluster.txt"

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-bench-out-of-cluster.txt',
                  reportName: "Kube bench (out of cluster) Report"
              ])
            } 
          }
        }


        stage ('Kube-score (cluster) Stage') {
          steps {
            script{
              try{
                sh 'cat clusterresources.txt | kube-score score - -o ci > kube-score-cluster.txt'
              }catch (exc) {} 

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-score-cluster.txt',
                  reportName: "Kube Score (Cluster) Report"
              ])
            }
          }
        }

        stage ('Kube-score (helm) Stage') {
          steps {
            script{
              try{
                sh 'cat helmtemplate.txt | kube-score score - -o ci > kube-score-helm.txt'
              }catch (exc) {} 

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-score-helm.txt',
                  reportName: "Kube Score (Helm) Report"
              ])
            }
          }
        }

        stage ('Kube-val (Cluster) Stage') {
          steps {
            script{
              try{
                sh 'cat clusterresources.txt | kubeval --ignore-missing-schemas > kube-val-cluster.txt'
              }catch (exc) {} 

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-val-cluster.txt',
                  reportName: "Kube Val (Cluster) Report"
              ])
            }
          }
        }


        stage ('Kube-val (Helm) Stage') {
          steps {
            script{
              try{
                sh 'cat helmtemplate.txt | kubeval --ignore-missing-schemas > kube-val-helm.txt'
              }catch (exc) {} 

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'kube-val-helm.txt',
                  reportName: "Kube Val (Helm) Report"
              ])
            }
          }
        }

        stage ('nmap Stage') {
          steps {
            script{
              try{
                sh 'chmod +x nmap.sh'
                sh './nmap.sh frontend.kieni.at'
              }catch (exc) {} 

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'nmap-frontend.kieni.at.txt',
                  reportName: "nmap Report"
              ])
            }
          }
        }

        stage ('harvester Stage') {
          steps {
            script{
              try{
                sh 'chmod +x harvester.sh'
                sh './harvester.sh frontend.kieni.at > harvester.txt'
              }catch (exc) {} 

              publishHTML (target: [
                  allowMissing: false,
                  alwaysLinkToLastBuild: false,
                  keepAll: true,
                  reportDir: './',
                  reportFiles: 'harvester.txt',
                  reportName: "harvester Report"
              ])
            }
          }
        }
      }
    }
  }
}