> TODO (Troubleshooting OpenShift 4.x)[https://access.redhat.com/articles/4292081]


tar xvf openshift-install-mac-4.3.0.tar.gz
mkdir openshift-installer
mv README.md openshift-installer
mv openshift-install  ocp-installer


ssh-keygen -t rsa -b 4096 -N '' \\n    -f ~/.ssh/id_rsa_ocp_deployer_43
eval "$(ssh-agent -s)"
ssh-add  /Users/rajivranjan/.ssh/id_rsa_ocp_deployer_43

cd ocp-installer
mkdir generated-files
./openshift-install create install-config --dir=./generated-files
cd ~/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/

cp install-config.yaml install-config.yaml.original


 ./openshift-install create manifests --dir=./generated-files
 
 rm -f openshift/99_openshift-cluster-api_master-machines-*.yaml

 # The Ignition configs contain a unique cluster identifier that you can use to uniquely identify your cluster in Amazon Web Services (AWS). The provided CloudFormation templates contain references to this infrastructure name.
 # c1-ocp43-wvp27


# VPC cloudformation
aws cloudformation create-stack --stack-name cluster-vpc --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/vpc-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/vpc-param.json

{
    "StackId": "arn:aws:cloudformation:ap-southeast-1:617305607146:stack/cluster-vpc/9e23dcd0-40ff-11ea-b95f-02d60855aea4"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-vpc/01c70930-4103-11ea-9507-027843ee7a02",
            "StackName": "cluster-vpc",
            "Description": "Template for Best Practice VPC with 1-3 AZs",
            "Parameters": [
                {
                    "ParameterKey": "SubnetBits",
                    "ParameterValue": "12"
                },
                {
                    "ParameterKey": "VpcCidr",
                    "ParameterValue": "10.0.0.0/16"
                },
                {
                    "ParameterKey": "AvailabilityZoneCount",
                    "ParameterValue": "1"
                }
            ],
            "CreationTime": "2020-01-27T12:46:16.067Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Outputs": [
                {
                    "OutputKey": "PrivateSubnetIds",
                    "OutputValue": "subnet-098fa1480b5b98b88",
                    "Description": "Subnet IDs of the private subnets."
                },
                {
                    "OutputKey": "PublicSubnetIds",
                    "OutputValue": "subnet-025cf141c951c4b50",
                    "Description": "Subnet IDs of the public subnets."
                },
                {
                    "OutputKey": "VpcId",
                    "OutputValue": "vpc-01a72bf82a0cdd919",
                    "Description": "ID of the new VPC."
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}

# aws DNS networking and hosted zones
aws route53 list-hosted-zones-by-name | jq --arg name "techbeaker.com." -r '.HostedZones | .[] | select(.Name=="\($name)") | .Id'

aws cloudformation create-stack --stack-name cluster-dns --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/network-config-aws-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/network-config-aws-param.json --capabilities CAPABILITY_NAMED_IAM
{
    "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-dns/8ae2dda0-410f-11ea-926f-0aa78e4848ba"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-dns/8ae2dda0-410f-11ea-926f-0aa78e4848ba",
            "StackName": "cluster-dns",
            "Description": "Template for OpenShift Cluster Network Elements (Route53 & LBs)",
            "Parameters": [
                {
                    "ParameterKey": "InfrastructureName",
                    "ParameterValue": "c1-ocp43-wvp27"
                },
                {
                    "ParameterKey": "PrivateSubnets",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "HostedZoneName",
                    "ParameterValue": "techbeaker.com"
                },
                {
                    "ParameterKey": "VpcId",
                    "ParameterValue": "vpc-01a72bf82a0cdd919"
                },
                {
                    "ParameterKey": "HostedZoneId",
                    "ParameterValue": "Z11Q16EPHOA6PF"
                },
                {
                    "ParameterKey": "PublicSubnets",
                    "ParameterValue": "subnet-025cf141c951c4b50"
                },
                {
                    "ParameterKey": "ClusterName",
                    "ParameterValue": "c1-ocp43"
                }
            ],
            "CreationTime": "2020-01-27T14:16:00.007Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Capabilities": [
                "CAPABILITY_NAMED_IAM"
            ],
            "Outputs": [
                {
                    "OutputKey": "ExternalApiTargetGroupArn",
                    "OutputValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Exter-1MMJ5YLDTZ8W0/3bc470b1562c0ddd",
                    "Description": "ARN of External API target group."
                },
                {
                    "OutputKey": "InternalApiTargetGroupArn",
                    "OutputValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Inter-103UR3WGC3D3O/7be13736126d1dd6",
                    "Description": "ARN of Internal API target group."
                },
                {
                    "OutputKey": "ApiServerDnsName",
                    "OutputValue": "api-int.c1-ocp43.techbeaker.com",
                    "Description": "Full hostname of the API server, which is required for the Ignition config files."
                },
                {
                    "OutputKey": "PrivateHostedZoneId",
                    "OutputValue": "Z10267154H59KHTPXQER",
                    "Description": "Hosted zone ID for the private DNS, which is required for private records."
                },
                {
                    "OutputKey": "InternalApiLoadBalancerName",
                    "OutputValue": "net/c1-ocp43-wvp27-int/74f7a6cb5563d75e",
                    "Description": "Full name of the Internal API load balancer created."
                },
                {
                    "OutputKey": "RegisterNlbIpTargetsLambda",
                    "OutputValue": "arn:aws:lambda:ap-south-1:617305607146:function:cluster-dns-RegisterNlbIpTargets-UHVR5FT4JN5T",
                    "Description": "Lambda ARN useful to help register or deregister IP targets for these load balancers."
                },
                {
                    "OutputKey": "InternalServiceTargetGroupArn",
                    "OutputValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Inter-1SVXOX6U2BQU2/5b37f426906f7d87",
                    "Description": "ARN of internal service target group."
                },
                {
                    "OutputKey": "ExternalApiLoadBalancerName",
                    "OutputValue": "net/c1-ocp43-wvp27-ext/89bfe8ae052a14c1",
                    "Description": "Full name of the External API load balancer created."
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}

# security groups and roles
aws cloudformation create-stack --stack-name cluster-sec --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/security-groups-roles-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/security-groups-roles-param.json --capabilities CAPABILITY_NAMED_IAM

{
    "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-sec/ceba13e0-4128-11ea-9d87-0a60c7dae728"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-sec/ceba13e0-4128-11ea-9d87-0a60c7dae728",
            "StackName": "cluster-sec",
            "Description": "Template for OpenShift Cluster Security Elements (Security Groups & IAM)",
            "Parameters": [
                {
                    "ParameterKey": "InfrastructureName",
                    "ParameterValue": "c1-ocp43-wvp27"
                },
                {
                    "ParameterKey": "PrivateSubnets",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "VpcCidr",
                    "ParameterValue": "10.0.0.0/16"
                },
                {
                    "ParameterKey": "VpcId",
                    "ParameterValue": "vpc-01a72bf82a0cdd919"
                }
            ],
            "CreationTime": "2020-01-27T17:16:51.189Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Capabilities": [
                "CAPABILITY_NAMED_IAM"
            ],
            "Outputs": [
                {
                    "OutputKey": "MasterSecurityGroupId",
                    "OutputValue": "sg-0b4fa7a4a08fb0d94",
                    "Description": "Master Security Group ID"
                },
                {
                    "OutputKey": "MasterInstanceProfile",
                    "OutputValue": "cluster-sec-MasterInstanceProfile-1OMB7O34KKCTP",
                    "Description": "Master IAM Instance Profile"
                },
                {
                    "OutputKey": "WorkerSecurityGroupId",
                    "OutputValue": "sg-083662730cec0e197",
                    "Description": "Worker Security Group ID"
                },
                {
                    "OutputKey": "WorkerInstanceProfile",
                    "OutputValue": "cluster-sec-WorkerInstanceProfile-1MU3NKUBGHJH5",
                    "Description": "Worker IAM Instance Profile"
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}


# S3 cluster bucket for ignition file

aws s3 mb s3://c1-ocp43-infra
aws s3 cp 

# bootstrap machine 
aws cloudformation create-stack --stack-name cluster-bootstrap --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/bootstrap-machine-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/bootstrap-machine-param.json --capabilities CAPABILITY_NAMED_IAM

{
    "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-bootstrap/bbbc07f0-4176-11ea-a085-0aac1af93896"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-bootstrap/bbbc07f0-4176-11ea-a085-0aac1af93896",
            "StackName": "cluster-bootstrap",
            "Description": "Template for OpenShift Cluster Bootstrap (EC2 Instance, Security Groups and IAM)",
            "Parameters": [
                {
                    "ParameterKey": "ExternalApiTargetGroupArn",
                    "ParameterValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Exter-1MMJ5YLDTZ8W0/3bc470b1562c0ddd"
                },
                {
                    "ParameterKey": "InfrastructureName",
                    "ParameterValue": "c1-ocp43-wvp27"
                },
                {
                    "ParameterKey": "RegisterNlbIpTargetsLambdaArn",
                    "ParameterValue": "arn:aws:lambda:ap-south-1:617305607146:function:cluster-dns-RegisterNlbIpTargets-UHVR5FT4JN5T"
                },
                {
                    "ParameterKey": "InternalApiTargetGroupArn",
                    "ParameterValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Inter-103UR3WGC3D3O/7be13736126d1dd6"
                },
                {
                    "ParameterKey": "AutoRegisterELB",
                    "ParameterValue": "yes"
                },
                {
                    "ParameterKey": "VpcId",
                    "ParameterValue": "vpc-01a72bf82a0cdd919"
                },
                {
                    "ParameterKey": "RhcosAmi",
                    "ParameterValue": "ami-0bf62e963a473068e"
                },
                {
                    "ParameterKey": "MasterSecurityGroupId",
                    "ParameterValue": "sg-0b4fa7a4a08fb0d94"
                },
                {
                    "ParameterKey": "AllowedBootstrapSshCidr",
                    "ParameterValue": "0.0.0.0/0"
                },
                {
                    "ParameterKey": "PublicSubnet",
                    "ParameterValue": "subnet-025cf141c951c4b50"
                },
                {
                    "ParameterKey": "BootstrapIgnitionLocation",
                    "ParameterValue": "s3://c1-ocp43-infra/bootstrap.ign"
                },
                {
                    "ParameterKey": "InternalServiceTargetGroupArn",
                    "ParameterValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Inter-1SVXOX6U2BQU2/5b37f426906f7d87"
                }
            ],
            "CreationTime": "2020-01-28T02:34:40.068Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Capabilities": [
                "CAPABILITY_NAMED_IAM"
            ],
            "Outputs": [
                {
                    "OutputKey": "BootstrapInstanceId",
                    "OutputValue": "i-0d1a074870ebd3f54",
                    "Description": "Bootstrap Instance ID."
                },
                {
                    "OutputKey": "BootstrapPublicIp",
                    "OutputValue": "15.206.123.110",
                    "Description": "The bootstrap node public IP address."
                },
                {
                    "OutputKey": "BootstrapPrivateIp",
                    "OutputValue": "10.0.15.235",
                    "Description": "The bootstrap node private IP address."
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}

# control plane machines

aws cloudformation create-stack --stack-name cluster-control-plane --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/control-plane-machine-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/control-plane-machines-param.json
{
    "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-control-plane/cd0c7fc0-417c-11ea-8775-0a6895f2a65c"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-control-plane/cd0c7fc0-417c-11ea-8775-0a6895f2a65c",
            "StackName": "cluster-control-plane",
            "Description": "Template for OpenShift Cluster Node Launch (EC2 master instances)",
            "Parameters": [
                {
                    "ParameterKey": "ExternalApiTargetGroupArn",
                    "ParameterValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Exter-1MMJ5YLDTZ8W0/3bc470b1562c0ddd"
                },
                {
                    "ParameterKey": "InfrastructureName",
                    "ParameterValue": "c1-ocp43-wvp27"
                },
                {
                    "ParameterKey": "IgnitionLocation",
                    "ParameterValue": "https://api-int.c1-ocp43.techbeaker.com:22623/config/master"
                },
                {
                    "ParameterKey": "CertificateAuthorities",
                    "ParameterValue": "data:text/plain;charset=utf-8;base64,LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFRENDQWZpZ0F3SUJBZ0lJRnk0WFV1ZW9UNkl3RFFZSktvWklodmNOQVFFTEJRQXdKakVTTUJBR0ExVUUKQ3hNSmIzQmxibk5vYVdaME1SQXdEZ1lEVlFRREV3ZHliMjkwTFdOaE1CNFhEVEl3TURFeU56RXdNek14TTFvWApEVE13TURFeU5ERXdNek14TTFvd0pqRVNNQkFHQTFVRUN4TUpiM0JsYm5Ob2FXWjBNUkF3RGdZRFZRUURFd2R5CmIyOTBMV05oTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFwR1JjVmxqNEJpRlMKVnkxZHQ0RnJEQXpiUFFVeVkxZGw0RVk0QTE5V1lxNTZFTnUzaENBdnFkcW5jSnBnclkyR09IRmpockpaTThRbgp1M2pYN0cyOEw3MGtKS2orazF2d1RvL21uQjdnemIzSExQNy9EMmIyQXNTN3dFb0R6MFo3aDVMQklDaWdIRWRiCmNPdGZHdW9ycjQ4M2xBblFDeWVYbENyclhGczhjZVRGb0JJSEgvL0Jpb3BhZHNEUlNxbmI5KzQ2RGhFQmhFSlgKRFF4RDBPWGZrTDZJR3Q5MmN3QkdQajlUTU9WYzhML2tSS1haQmYyYzgreFNTM2svK21GZmx0Y1o2TmJZNThyZAp6L0kyYkEvUnRiYnZ2bTM0a3ZTTkZvaWJzUGhTZGk3ZjRUVjhma0dxbTZPb2JnUm9QNUZldWhlazJVQU9URkRjCkxGVjJGczJObHdJREFRQUJvMEl3UURBT0JnTlZIUThCQWY4RUJBTUNBcVF3RHdZRFZSMFRBUUgvQkFVd0F3RUIKL3pBZEJnTlZIUTRFRmdRVVpYVTMyanFHL0FtVDFJT2FENG1veEhGUXFnZ3dEUVlKS29aSWh2Y05BUUVMQlFBRApnZ0VCQUduNzN0aUQraDdacUlFamtGS3F4Q0RWcE1QMXB6Rk5hemorRHdnR2lBTzhTM2U5N0U3dWNEWlpraTNoCjZmc0lHaTJhR05BdldwRmF3SE9CRElTVzF3WFA3QWxOSTlnVjVCQUhFR2FrTHBYWDBmZW5QSThxUkYyK0w0NVgKMllJMWU2eUNVUkhkWFk2U002Zk56bjV5R1U0aWE1VGFjb1BrSUNJcHU4M09XUnFJS3hDc29PQlZLQVcyOGZrMwpYekdMZkNXZDJnRGxwc2hOZ1p5ZUtCYXBIMFdsVGdEaEpSRFlqbUIwNVRIR3MyQzk5SndxQkJQS2ZVcnd2WGlPClJwOTY3VDc1UTRzK3dTcm9TQlIrSlRyNklEU1pPQ2VVWDlvU2tWYkk2elh6VmhPOWxBVWtNYVBZS1FpelVHVCsKS25GUkFMNndnNW83dE1wWFR1YitCZS9CbkNzPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
                },
                {
                    "ParameterKey": "RegisterNlbIpTargetsLambdaArn",
                    "ParameterValue": "arn:aws:lambda:ap-south-1:617305607146:function:cluster-dns-RegisterNlbIpTargets-UHVR5FT4JN5T"
                },
                {
                    "ParameterKey": "InternalApiTargetGroupArn",
                    "ParameterValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Inter-103UR3WGC3D3O/7be13736126d1dd6"
                },
                {
                    "ParameterKey": "RhcosAmi",
                    "ParameterValue": "ami-0bf62e963a473068e"
                },
                {
                    "ParameterKey": "Master0Subnet",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "PrivateHostedZoneId",
                    "ParameterValue": "Z10267154H59KHTPXQER"
                },
                {
                    "ParameterKey": "MasterInstanceType",
                    "ParameterValue": "m4.xlarge"
                },
                {
                    "ParameterKey": "AutoRegisterDNS",
                    "ParameterValue": "yes"
                },
                {
                    "ParameterKey": "AutoRegisterELB",
                    "ParameterValue": "yes"
                },
                {
                    "ParameterKey": "Master2Subnet",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "MasterSecurityGroupId",
                    "ParameterValue": "sg-0b4fa7a4a08fb0d94"
                },
                {
                    "ParameterKey": "Master1Subnet",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "MasterInstanceProfileName",
                    "ParameterValue": "cluster-sec-MasterInstanceProfile-1OMB7O34KKCTP"
                },
                {
                    "ParameterKey": "InternalServiceTargetGroupArn",
                    "ParameterValue": "arn:aws:elasticloadbalancing:ap-south-1:617305607146:targetgroup/clust-Inter-1SVXOX6U2BQU2/5b37f426906f7d87"
                },
                {
                    "ParameterKey": "PrivateHostedZoneName",
                    "ParameterValue": "c1-ocp43.techbeaker.com"
                }
            ],
            "CreationTime": "2020-01-28T03:18:06.064Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Outputs": [
                {
                    "OutputKey": "PrivateIPs",
                    "OutputValue": "10.0.52.84,10.0.57.80,10.0.57.192",
                    "Description": "The control-plane node private IP addresses."
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}




# initialize bootstrap machine

./openshift-install wait-for bootstrap-complete --dir=/Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/generated-files --log-level=debug

# worker nodes
aws cloudformation create-stack --stack-name cluster-worker --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/worker-nodes-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/worker-nodes-param.json

{
    "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-worker/487f4b70-4181-11ea-a60c-06e4827d8e82"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-worker/487f4b70-4181-11ea-a60c-06e4827d8e82",
            "StackName": "cluster-worker",
            "Description": "Template for OpenShift Cluster Node Launch (EC2 worker instance)",
            "Parameters": [
                {
                    "ParameterKey": "InfrastructureName",
                    "ParameterValue": "c1-ocp43-wvp27"
                },
                {
                    "ParameterKey": "IgnitionLocation",
                    "ParameterValue": "https://api-int.c1-ocp43.techbeaker.com:22623/config/worker"
                },
                {
                    "ParameterKey": "CertificateAuthorities",
                    "ParameterValue": "data:text/plain;charset=utf-8;base64,LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFRENDQWZpZ0F3SUJBZ0lJRnk0WFV1ZW9UNkl3RFFZSktvWklodmNOQVFFTEJRQXdKakVTTUJBR0ExVUUKQ3hNSmIzQmxibk5vYVdaME1SQXdEZ1lEVlFRREV3ZHliMjkwTFdOaE1CNFhEVEl3TURFeU56RXdNek14TTFvWApEVE13TURFeU5ERXdNek14TTFvd0pqRVNNQkFHQTFVRUN4TUpiM0JsYm5Ob2FXWjBNUkF3RGdZRFZRUURFd2R5CmIyOTBMV05oTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFwR1JjVmxqNEJpRlMKVnkxZHQ0RnJEQXpiUFFVeVkxZGw0RVk0QTE5V1lxNTZFTnUzaENBdnFkcW5jSnBnclkyR09IRmpockpaTThRbgp1M2pYN0cyOEw3MGtKS2orazF2d1RvL21uQjdnemIzSExQNy9EMmIyQXNTN3dFb0R6MFo3aDVMQklDaWdIRWRiCmNPdGZHdW9ycjQ4M2xBblFDeWVYbENyclhGczhjZVRGb0JJSEgvL0Jpb3BhZHNEUlNxbmI5KzQ2RGhFQmhFSlgKRFF4RDBPWGZrTDZJR3Q5MmN3QkdQajlUTU9WYzhML2tSS1haQmYyYzgreFNTM2svK21GZmx0Y1o2TmJZNThyZAp6L0kyYkEvUnRiYnZ2bTM0a3ZTTkZvaWJzUGhTZGk3ZjRUVjhma0dxbTZPb2JnUm9QNUZldWhlazJVQU9URkRjCkxGVjJGczJObHdJREFRQUJvMEl3UURBT0JnTlZIUThCQWY4RUJBTUNBcVF3RHdZRFZSMFRBUUgvQkFVd0F3RUIKL3pBZEJnTlZIUTRFRmdRVVpYVTMyanFHL0FtVDFJT2FENG1veEhGUXFnZ3dEUVlKS29aSWh2Y05BUUVMQlFBRApnZ0VCQUduNzN0aUQraDdacUlFamtGS3F4Q0RWcE1QMXB6Rk5hemorRHdnR2lBTzhTM2U5N0U3dWNEWlpraTNoCjZmc0lHaTJhR05BdldwRmF3SE9CRElTVzF3WFA3QWxOSTlnVjVCQUhFR2FrTHBYWDBmZW5QSThxUkYyK0w0NVgKMllJMWU2eUNVUkhkWFk2U002Zk56bjV5R1U0aWE1VGFjb1BrSUNJcHU4M09XUnFJS3hDc29PQlZLQVcyOGZrMwpYekdMZkNXZDJnRGxwc2hOZ1p5ZUtCYXBIMFdsVGdEaEpSRFlqbUIwNVRIR3MyQzk5SndxQkJQS2ZVcnd2WGlPClJwOTY3VDc1UTRzK3dTcm9TQlIrSlRyNklEU1pPQ2VVWDlvU2tWYkk2elh6VmhPOWxBVWtNYVBZS1FpelVHVCsKS25GUkFMNndnNW83dE1wWFR1YitCZS9CbkNzPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
                },
                {
                    "ParameterKey": "RhcosAmi",
                    "ParameterValue": "ami-0bf62e963a473068e"
                },
                {
                    "ParameterKey": "WorkerInstanceProfileName",
                    "ParameterValue": "cluster-sec-WorkerInstanceProfile-1MU3NKUBGHJH5"
                },
                {
                    "ParameterKey": "WorkerSecurityGroupId",
                    "ParameterValue": "sg-083662730cec0e197"
                },
                {
                    "ParameterKey": "Subnet",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "WorkerInstanceType",
                    "ParameterValue": "m4.large"
                }
            ],
            "CreationTime": "2020-01-28T03:50:11.147Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Outputs": [
                {
                    "OutputKey": "PrivateIP",
                    "OutputValue": "10.0.60.211",
                    "Description": "The compute node private IP address."
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}


aws cloudformation create-stack --stack-name cluster-worker1-2 --template-body file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/worker1-2-nodes-template.yaml --parameters file:///Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/worker-nodes-param.json

{
    "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-worker1-2/1fa399e0-4186-11ea-ae71-0aa7e2913d94"
}

{
    "Stacks": [
        {
            "StackId": "arn:aws:cloudformation:ap-south-1:617305607146:stack/cluster-worker1-2/1fa399e0-4186-11ea-ae71-0aa7e2913d94",
            "StackName": "cluster-worker1-2",
            "Description": "Template for OpenShift Cluster Node Launch (EC2 worker instance)",
            "Parameters": [
                {
                    "ParameterKey": "InfrastructureName",
                    "ParameterValue": "c1-ocp43-wvp27"
                },
                {
                    "ParameterKey": "IgnitionLocation",
                    "ParameterValue": "https://api-int.c1-ocp43.techbeaker.com:22623/config/worker"
                },
                {
                    "ParameterKey": "CertificateAuthorities",
                    "ParameterValue": "data:text/plain;charset=utf-8;base64,LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFRENDQWZpZ0F3SUJBZ0lJRnk0WFV1ZW9UNkl3RFFZSktvWklodmNOQVFFTEJRQXdKakVTTUJBR0ExVUUKQ3hNSmIzQmxibk5vYVdaME1SQXdEZ1lEVlFRREV3ZHliMjkwTFdOaE1CNFhEVEl3TURFeU56RXdNek14TTFvWApEVE13TURFeU5ERXdNek14TTFvd0pqRVNNQkFHQTFVRUN4TUpiM0JsYm5Ob2FXWjBNUkF3RGdZRFZRUURFd2R5CmIyOTBMV05oTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFwR1JjVmxqNEJpRlMKVnkxZHQ0RnJEQXpiUFFVeVkxZGw0RVk0QTE5V1lxNTZFTnUzaENBdnFkcW5jSnBnclkyR09IRmpockpaTThRbgp1M2pYN0cyOEw3MGtKS2orazF2d1RvL21uQjdnemIzSExQNy9EMmIyQXNTN3dFb0R6MFo3aDVMQklDaWdIRWRiCmNPdGZHdW9ycjQ4M2xBblFDeWVYbENyclhGczhjZVRGb0JJSEgvL0Jpb3BhZHNEUlNxbmI5KzQ2RGhFQmhFSlgKRFF4RDBPWGZrTDZJR3Q5MmN3QkdQajlUTU9WYzhML2tSS1haQmYyYzgreFNTM2svK21GZmx0Y1o2TmJZNThyZAp6L0kyYkEvUnRiYnZ2bTM0a3ZTTkZvaWJzUGhTZGk3ZjRUVjhma0dxbTZPb2JnUm9QNUZldWhlazJVQU9URkRjCkxGVjJGczJObHdJREFRQUJvMEl3UURBT0JnTlZIUThCQWY4RUJBTUNBcVF3RHdZRFZSMFRBUUgvQkFVd0F3RUIKL3pBZEJnTlZIUTRFRmdRVVpYVTMyanFHL0FtVDFJT2FENG1veEhGUXFnZ3dEUVlKS29aSWh2Y05BUUVMQlFBRApnZ0VCQUduNzN0aUQraDdacUlFamtGS3F4Q0RWcE1QMXB6Rk5hemorRHdnR2lBTzhTM2U5N0U3dWNEWlpraTNoCjZmc0lHaTJhR05BdldwRmF3SE9CRElTVzF3WFA3QWxOSTlnVjVCQUhFR2FrTHBYWDBmZW5QSThxUkYyK0w0NVgKMllJMWU2eUNVUkhkWFk2U002Zk56bjV5R1U0aWE1VGFjb1BrSUNJcHU4M09XUnFJS3hDc29PQlZLQVcyOGZrMwpYekdMZkNXZDJnRGxwc2hOZ1p5ZUtCYXBIMFdsVGdEaEpSRFlqbUIwNVRIR3MyQzk5SndxQkJQS2ZVcnd2WGlPClJwOTY3VDc1UTRzK3dTcm9TQlIrSlRyNklEU1pPQ2VVWDlvU2tWYkk2elh6VmhPOWxBVWtNYVBZS1FpelVHVCsKS25GUkFMNndnNW83dE1wWFR1YitCZS9CbkNzPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
                },
                {
                    "ParameterKey": "RhcosAmi",
                    "ParameterValue": "ami-0bf62e963a473068e"
                },
                {
                    "ParameterKey": "WorkerInstanceProfileName",
                    "ParameterValue": "cluster-sec-WorkerInstanceProfile-1MU3NKUBGHJH5"
                },
                {
                    "ParameterKey": "WorkerSecurityGroupId",
                    "ParameterValue": "sg-083662730cec0e197"
                },
                {
                    "ParameterKey": "Subnet",
                    "ParameterValue": "subnet-098fa1480b5b98b88"
                },
                {
                    "ParameterKey": "WorkerInstanceType",
                    "ParameterValue": "m4.large"
                }
            ],
            "CreationTime": "2020-01-28T04:25:30.584Z",
            "RollbackConfiguration": {},
            "StackStatus": "CREATE_COMPLETE",
            "DisableRollback": false,
            "NotificationARNs": [],
            "Outputs": [
                {
                    "OutputKey": "PrivateIP2",
                    "OutputValue": "10.0.61.35",
                    "Description": "The compute node private IP address."
                },
                {
                    "OutputKey": "PrivateIP1",
                    "OutputValue": "10.0.50.178",
                    "Description": "The compute node private IP address."
                }
            ],
            "Tags": [],
            "EnableTerminationProtection": false,
            "DriftInformation": {
                "StackDriftStatus": "NOT_CHECKED"
            }
        }
    ]
}


# approve csr then the worker node is added to the cluster


# Adding ingress router
apps.c1-ocp43.techbeaker.com

# external ip of the router
oc -n openshift-ingress get service router-default
a114e4b5f79c147e48ca5955b7f4ac3a-2142125589.ap-south-1.elb.amazonaws.com

aws elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[] | select(.DNSName == "a114e4b5f79c147e48ca5955b7f4ac3a-2142125589.ap-south-1.elb.amazonaws.com").CanonicalHostedZoneNameID'
ZP97RAFLXTNZK

aws route53 list-hosted-zones-by-name --dns-name "techbeaker.com" --query 'HostedZones[? Config.PrivateZone != `true` && Name == `techbeaker.com.`].Id' --output text
/hostedzone/Z11Q16EPHOA6PF

# add to private zone
aws route53 change-resource-record-sets --hosted-zone-id "Z10267154H59KHTPXQER" --change-batch '{"Changes": [{"Action": "CREATE","ResourceRecordSet": {"Name": "\\052.apps.c1-ocp43.techbeaker.com","Type": "A","AliasTarget":{"HostedZoneId": "ZP97RAFLXTNZK", "DNSName": "a114e4b5f79c147e48ca5955b7f4ac3a-2142125589.ap-south-1.elb.amazonaws.com.", "EvaluateTargetHealth": false}}}]}'


# add to public zone
aws route53 change-resource-record-sets --hosted-zone-id "Z11Q16EPHOA6PF" --change-batch '{"Changes": [{"Action": "CREATE","ResourceRecordSet": {"Name": "\\052.apps.c1-ocp43.techbeaker.com","Type": "A","AliasTarget":{"HostedZoneId": "ZP97RAFLXTNZK", "DNSName": "a114e4b5f79c147e48ca5955b7f4ac3a-2142125589.ap-south-1.elb.amazonaws.com.", "EvaluateTargetHealth": false}}}]}'

# master external
c1-ocp43-wvp27-ext-89bfe8ae052a14c1.elb.ap-south-1.amazonaws.com.
ZVDDRBQ08TROA


a114e4b5f79c147e48ca5955b7f4ac3a-2142125589.ap-south-1.elb.amazonaws.com
ZP97RAFLXTNZK

# delete the bootstrap stack
aws cloudformation delete-stack --stack-name  cluster-bootstrap

# complete the UPI

./openshift-install --dir=/Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/generated-files/ wait-for install-complete
INFO Waiting up to 30m0s for the cluster at https://api.c1-ocp43.techbeaker.com:6443 to initialize...
INFO Waiting up to 10m0s for the openshift-console route to be created...
INFO Install complete!
INFO To access the cluster as the system:admin user when using 'oc', run 'export KUBECONFIG=/Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/generated-files/auth/kubeconfig'
INFO Access the OpenShift web-console here: https://console-openshift-console.apps.c1-ocp43.techbeaker.com
INFO Login to the console with user: kubeadmin, password: 6yQX3-jhWPb-n7ts9-puawu

# destroy the cluster
./openshift-install destroy cluster --dir=/Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/generated-files/ --log-level=debug

# add users with respective permissions

oc create secret generic htpass-secret --from-file=htpasswd=/Users/rajivranjan/Documents/OpenShift/ocp4.x/AWS/UPI-4.3/ocp-installer/users.htpasswd -n openshift-config

oc apply -f CR-htpasswd.yaml

26214400
5242880