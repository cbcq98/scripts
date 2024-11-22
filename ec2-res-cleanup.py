import boto3 

# Initialize EC2 client 
ec2 = boto3.client('ec2', region_name='us-east-1')

# Stop instances 
instance_ids = ['i-0123456789abcdef0', 'i-0abcdef1234567890'] 
response = ec2.stop_instances(InstanceIds=instance_ids) 
print("Stopping instances:", response) 
