node ('virtualbox') {
  def directory = "ansible-role-sudo"
  stage 'Clean up'
  deleteDir()
  stage 'Checkout'
  sh "if [ ! -d $directory ]; then mkdir $directory; fi"
  dir("$directory") {
    checkout scm
  }
  dir("$directory") {
    stage 'bundle'
    sh 'bundle install --path vendor/bundle'

    stage 'bundle exec kitchen test'
    try {
      sh 'bundle exec kitchen test'
    } finally {
      sh 'bundle exec kitchen destroy'
    }

    stage 'Notify'
    step([$class: 'GitHubCommitNotifier', resultOnFailure: 'FAILURE'])
  }
}
