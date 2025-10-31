#!/usr/bin/env python3
"""
Fixed AWS Architecture Diagram for Asianchallenge_3
Corrected version with proper connections and components
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.network import Route53, ELB, PublicSubnet, RouteTable, InternetGateway
from diagrams.aws.compute import EC2
from diagrams.aws.security import ACM, IAM
from diagrams.aws.general import General
from diagrams.programming.framework import Flask
from diagrams.onprem.client import Users
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.network import Nginx

# Diagram configuration
graph_attr = {
    "fontsize": "12",
    "bgcolor": "white",
    "pad": "0.5",
    "ranksep": "1.0",
    "nodesep": "0.7",
    "splines": "ortho"
}

node_attr = {
    "fontsize": "10",
    "width": "1.5",
    "height": "1.5"
}

with Diagram("Asianchallenge_3 AWS Architecture (Fixed)", 
             filename="aws_architecture_fixed", 
             show=False,
             direction="TB",
             graph_attr=graph_attr,
             node_attr=node_attr):
    
    # External
    users = Users("Users")
    
    # DNS
    route53 = Route53("Route 53\nroten-app.com\nHosted Zone ID:\nZ04063947ZOXL77XCSM8")
    
    with Cluster("AWS Cloud (ap-northeast-1)"):
        # Internet Gateway
        igw = InternetGateway("Internet Gateway\n(MyInternetGateway)")
        
        # ACM Certificate
        acm = ACM("ACM Certificate\nroten-app.com\nARN: ...09cfbc23...")
        
        with Cluster("VPC (10.0.0.0/16)\nEnableDnsHostnames: true"):
            
            # Route Table
            route_table = RouteTable("Public Route Table\n0.0.0.0/0 → IGW")
            
            # Subnets
            with Cluster("Availability Zone 1"):
                subnet1 = PublicSubnet("Public Subnet 1\n10.0.1.0/24\nMapPublicIpOnLaunch")
            
            with Cluster("Availability Zone 2"):
                subnet2 = PublicSubnet("Public Subnet 2\n10.0.2.0/24\nMapPublicIpOnLaunch")
            
            # ALB and its components
            with Cluster("Application Load Balancer (MyALB)"):
                alb = ELB("ALB\nListeners:\n• HTTP(80)→Redirect HTTPS\n• HTTPS(443)→Target Group")
                alb_sg = IAM("ALB Security Group\nInbound:\n• HTTP (80) from 0.0.0.0/0\n• HTTPS (443) from 0.0.0.0/0")
                
            # Target Group
            target_group = General("Target Group\n(MyTargetGroup)\nPort: 80, Protocol: HTTP\nHealth Check: /\nTarget: MyInstance")
            
            # EC2 Instance
            with Cluster("EC2 Instance (PublicSubnet1)"):
                ec2 = EC2("MyInstance\nt3.micro\nAMI: ami-07faa35bbd2230d90\nKey: asianchallenge-key")
                ec2_sg = IAM("Instance Security Group\nInbound:\n• SSH (22) from 0.0.0.0/0\n• HTTP (80) from ALB SG")
                
                with Cluster("Application Stack (UserData)"):
                    nginx = Nginx("Nginx\nPort 80\nProxy to 127.0.0.1:5000")
                    flask = Flask("Flask App\nPort 5000\n/opt/app/Asianchallenge_3/backend\nService: flask-app.service")
                    postgres = PostgreSQL("PostgreSQL 15\nPort 5432\nDB: quiz_rally\nUser: flaskuser")
    
    # Connections - Traffic Flow
    users >> Edge(label="1. DNS Query", style="dashed", color="gray") >> route53
    route53 >> Edge(label="2. A Record (Alias)", style="dashed", color="gray") >> alb
    users >> Edge(label="3. HTTPS (443)", color="darkgreen", style="bold") >> alb
    
    # VPC Networking - Fixed direction
    route_table >> Edge(label="Default Route", style="dotted", color="blue") >> igw
    subnet1 >> Edge(label="Associated", style="dotted", color="gray") >> route_table
    subnet2 >> Edge(label="Associated", style="dotted", color="gray") >> route_table
    
    # ALB connections
    alb >> Edge(label="Forward", color="blue") >> target_group
    target_group >> Edge(label="HTTP (80)", color="blue", style="bold") >> ec2
    alb << Edge(label="Certificate", style="dotted", color="orange") >> acm
    alb - Edge(label="Protected by", style="dotted") - alb_sg
    
    # ALB Multi-AZ placement
    alb << Edge(label="Node 1", style="dotted", color="lightgray") << subnet1
    alb << Edge(label="Node 2", style="dotted", color="lightgray") << subnet2
    
    # EC2 internal connections
    ec2 >> nginx
    nginx >> Edge(label="Proxy Pass\nlocalhost:5000", color="orange") >> flask
    flask >> Edge(label="Database\nlocalhost:5432", color="purple") >> postgres
    ec2 - Edge(label="Protected by", style="dotted") - ec2_sg

print("Fixed AWS architecture diagram generated successfully!")
print("Output file: aws_architecture_fixed.png")