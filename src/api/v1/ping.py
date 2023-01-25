import json

def main(event,context):

    response = {
        'message': 'success',
        'version': '0.3.0'
    }

    print(response)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,GET',
            'Access-Control-Allow-Credentials': 'true'
        },
        'body': json.dumps(response)
    }

if __name__ == "__main__":
    main('', '')