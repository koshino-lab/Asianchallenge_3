#!/usr/bin/env python3
"""
AWS Architecture Diagram for Asianchallenge_3
Generated from CloudFormation template.yaml
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.network import Route53, CloudFront, ELB, VPC, PublicSubnet, RouteTable, InternetGateway
from diagrams.aws.compute import EC2
from diagrams.aws.security import ACM, IAM
from diagrams.aws.database import RDS
from diagrams.programming.framework import Flask
from diagrams.onprem.client import Users
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.network import Nginx

# Diagram configuration
graph_attr = {
    "fontsize": "45",
    "bgcolor": "white",
    "layout": "dot",
    "rankdir": "TB",
    "nodesep": "0.8",
    "ranksep": "1.2"
}

with Diagram("Asianchallenge_3 AWS Architecture", 
             filename="aws_architecture", 
             show=False,
             direction="TB",
             graph_attr=graph_attr):
    
    # External users
    users = Users("Users")
    
    # DNS
    route53 = Route53("roten-app.com\nHosted Zone")
    
    # Internet Gateway
    igw = InternetGateway("Internet Gateway")
    
    with Cluster("AWS Cloud (ap-northeast-1)"):
        # ACM Certificate
        acm = ACM("SSL Certificate\nroten-app.com")
        
        with Cluster("VPC (10.0.0.0/16)"):
            # Route Table
            route_table = RouteTable("Public Route Table\n0.0.0.0/0 → IGW")
            
            # Application Load Balancer
            with Cluster("Application Load Balancer"):
                alb = ELB("ALB\nHTTP(80) → HTTPS(443)")
                alb_sg = IAM("ALB Security Group\nHTTP/HTTPS from 0.0.0.0/0")
            
            # Availability Zones
            with Cluster("Availability Zone 1"):
                subnet1 = PublicSubnet("Public Subnet 1\n10.0.1.0/24")
                
                with Cluster("EC2 Instance (t3.micro)"):
                    ec2 = EC2("MyInstance\nasianchallenge-key")
                    ec2_sg = IAM("Instance SG\nSSH(22), HTTP(80)")
                    
                    with Cluster("Application Stack"):
                        nginx = Nginx("Nginx\nPort 80")
                        flask = Flask("Flask App\nPort 5000")
                        postgres = PostgreSQL("PostgreSQL 15\nquiz_rally DB")
            
            with Cluster("Availability Zone 2"):
                subnet2 = PublicSubnet("Public Subnet 2\n10.0.2.0/24")
    
    # Connections
    users >> route53 >> Edge(label="DNS Resolution") >> alb
    users >> Edge(label="HTTPS(443)", style="bold") >> alb
    
    igw >> route_table
    route_table >> subnet1
    route_table >> subnet2
    
    alb >> Edge(label="HTTP(80)") >> nginx
    alb - acm
    alb - alb_sg
    
    nginx >> Edge(label="Proxy to\nlocalhost:5000") >> flask
    flask >> Edge(label="localhost:5432") >> postgres
    
    ec2 - ec2_sg
    subnet1 - ec2

print("AWS architecture diagram generated successfully!")
print("Output file: aws_architecture.png")