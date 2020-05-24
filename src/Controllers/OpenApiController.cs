using Microsoft.AspNetCore.Mvc;

namespace sudokusolver.Controllers
{
    [Route("swagger")]
    [Route("openapi")]
    [ApiController]
    public class OpenApiController : ControllerBase
    {
        /// <summary>
        /// return the OpenApi document
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("v1")]
        public IActionResult Get()
        {

            var stream = System.IO.File.OpenRead("Content/openapi.v1.yaml"); 
            return this.File(stream, "text/yaml", "openapi.v1.yaml");
        }

    }
}
