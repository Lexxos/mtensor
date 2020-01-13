pipeline{
	agent none
	triggers {
		cron('H H(0-7) * * *')
	}
	stages {
		stage('TENSOR CI'){
			parallel {
				
				stage('linux-x64') {
					agent { 
						dockerfile {
							filename 'tensor-dev-ubuntu18.04.dockerfile'
							dir 'dockerfile'
							// label 'my-defined-label'
							// additionalBuildArgs  '--build-arg version=1.0.2'
							// args '-v /tmp:/tmp'
						}
					}
					environment {
						CXX = 'g++'
						CC = 'gcc'
					}
					stages {
						stage('build') {
							steps {
								sh './script/build_native.sh'
							}
						}
					}
				}


				stage('linux-x64-cuda') {
					agent {
						dockerfile {
							filename 'tensor-dev-ubuntu18.04.dockerfile'
							dir 'dockerfile'
							args '--runtime=nvidia'
						}
					}
					environment {
						CXX = 'g++'
						CC = 'gcc'
					}
					stages {
						stage('build') {
							steps {
								sh './script/build_native.sh -DWITH_CUDA=ON'
							}
						}
						stage('test') {
							steps {
								sh 'echo hicudatest'
							}
						}
					}
				}

				stage('linux-aarch64') {
					stages {	
						stage('cross-build') {
							agent {
								dockerfile {
									filename 'tensor-dev-ubuntu18.04.dockerfile'
									dir 'dockerfile'
								}
							}
							environment {
								GCC_LINARO_TOOLCHAIN = '/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu'
							}
							steps {
								sh './script/build-linux-aarch64.sh'
							}
						}
					}
				}

				stage('linux-armv7') {
					agent {
						dockerfile {
							filename 'tensor-dev-ubuntu18.04.dockerfile'
							dir 'dockerfile'
						}
					}

					steps {
						sh './script/build-linux-arm.sh'
					}
				}
				 				
				stage('windows-x64') {
					agent {
						label 'Windows'
					}
					stages {
						stage('build'){
							steps {
								bat 'call ./script/build_windows.bat -DWITH_CUDA=ON'
							}
						}
					}
				}
				
				stage('android-armv7') {
					agent {
						dockerfile {
							filename 'tensor-dev-ubuntu18.04.dockerfile'
							dir 'dockerfile'
						}
					}
					stages {	
						stage('build') {
							steps {
								sh './script/build_android.sh'
							}
						}
						// stage('test') {s
						// 	steps {
						// 		sh 'echo armv7-test'
						// 		sh 'sshpass -p admin ssh -o StrictHostKeyChecking=no root@192.168.0.105 "echo lex620"'
						// 	}
						// }	
					}
				}
				
				// stage('macos-x64') {
				// 	agent {
				// 		label 'macos-x64'
				// 	}
				// 	stages {
				// 		stage('build') {
				// 			steps {
				// 				sh './script/build_native.sh'
				// 			}
				// 		}
				// 	}
				// }
			}
		}
	}
	post {
		always {
			echo 'This will always run'
		}
		success {
			echo 'This will run only ifsuccessful'
		}
		failure {
			echo 'This will run only iffailed'
		}
		unstable {
			echo 'This will run only if th run was marked as unstable'
		}
		changed {
			echo 'This will run only if th state of the Pipeline has changed'
			echo 'For example, if thePipeline was previously failing bu is now successful'
		}
	}
}
