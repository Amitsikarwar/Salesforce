public class RequestCallout {
    public static String calloutReq(String RequestedJson , string Endpoint_URL, string API_Method,String Token_URL,String tokenBodyVal) 
    {
        String response;
        Try
        {
            system.debug('RequestedJson Value :'+RequestedJson);
            system.debug(JSON.serialize(RequestedJson));
            String accessToken;
            if(Token_URL != null && Token_URL !='')
                accessToken=GenerateToken(Token_URL,tokenBodyVal);
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Endpoint_URL);
            req.setMethod(API_Method);
            if (RequestedJson!=null && accessToken !=null) {
                req.setHeader('x-access-token', accessToken);
            }
            req.setHeader('Content-Type', 'application/json');
            req.setBody(RequestedJson);
            req.setTimeout(120 * 1000);
            Http http = new Http();
            HttpResponse res = http.send(req);
            system.debug('Responce  :'+res);
            system.debug('Responce  :'+res.getBody());
            if (res.getStatusCode() == 200) 
            {
                response= res.getBody();
            }
        }Catch(DmlException e){
            System.debug('Exception'+e);
        }
        return response;
    }
     public static string GenerateToken(String Token_URL,String tokenBodyVal) {
        system.debug(Token_URL);
        system.debug(tokenBodyVal);
        string token = '';
        try {
            string requestJSON = '';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(Token_URL);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(tokenBodyVal);
            req.setTimeout(120 * 1000);
            Http http = new Http();
            HttpResponse res = http.send(req);
            string body = res.getBody();
            system.debug('Responce Serviec :'+res);
            if (res.getStatusCode() == 200) {
                
                TokenResponse tokenResponse = (TokenResponse) System.JSON.deserialize(body, TokenResponse.class);
                if (tokenResponse != null && string.isNotEmpty(tokenResponse.token)) {
                    token = tokenResponse.token;
                }
            }else{
                
            }
            system.debug(body);
        } catch (DmlException e) {
            System.debug('Exception'+e);
        }
         return token;
     }
        public class TokenResponse {
        public string token {
            get;
            set;
        }
    }
}