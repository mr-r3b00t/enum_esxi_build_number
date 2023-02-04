add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$target = "https://192.168.73.128"

$method = "POST"

$endpoint = "/sdk/"

$uri = $target + $endpoint

$uri

$userAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome

$payload = '<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><Header><operationID>esxui-1ca5</operationID></Header><Body><RetrieveServiceContent xmlns="urn:vim25"><_this type="ServiceInstance">ServiceInstance</_this></RetrieveServiceContent></Body></Envelope>'

$request = Invoke-RestMethod -Method Post -Uri $uri -Body $payload -UserAgent $userAgent -UseBasicParsing

$response = $request.InnerXml
