import json
import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.table('cloud-resume-table')
def lambda_handler(event, context):
    response = table.get_item(Key={
        'resume_views':'0'
    })
    views = response['Item']['views']
    views = views + 1
    print(views)
    response = table.put_item(Item={
        'resume_views':'0',
        'views': views
    })

    return views