using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Ards.Api.Models;

namespace Ards.NetCore.Ards.Api.Controllers
{
    /// <summary>
    /// SchemaInfor Controller
    /// </summary>
    [Route("api/SchemaInfo")]
    [ApiController]
    public class SchemaInfoController : ControllerBase
    {
        private readonly ArdsContext _context;

        /// <summary>
        /// Add Context to SchemaInfoController
        /// </summary>
        /// <param name="context"></param>
        public SchemaInfoController(ArdsContext context)
        {
            _context = context;
        }

        /// <summary>
        /// GET: api/SchemaInfo 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SchemaInfo>>> GetSchemaInfo()
        {
            return await _context.SchemaInfo.ToListAsync();
        }

        /// <summary>
        /// GET: api/SchemaInfo/5 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        public async Task<ActionResult<SchemaInfo>> GetSchemaInfo(string id)
        {
            var schemaInfo = await _context.SchemaInfo.FindAsync(id);

            if (schemaInfo == null)
            {
                return NotFound();
            }

            return schemaInfo;
        }

        /// <summary>
        /// PUT: api/SchemaInfo/5
        /// </summary>
        /// <param name="id"></param>
        /// <param name="schemaInfo"></param>
        /// <returns></returns>
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSchemaInfo(string id, SchemaInfo schemaInfo)
        {
            if (id != schemaInfo.SchemaName)
            {
                return BadRequest();
            }

            _context.Entry(schemaInfo).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SchemaInfoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        /// <summary>
        /// POST: api/SchemaInfo
        /// </summary>
        /// <param name="schemaInfo"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<ActionResult<SchemaInfo>> PostSchemaInfo(SchemaInfo schemaInfo)
        {
            _context.SchemaInfo.Add(schemaInfo);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SchemaInfoExists(schemaInfo.SchemaName))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetSchemaInfo", new { id = schemaInfo.SchemaName }, schemaInfo);
        }

        /// <summary>
        /// DELETE: api/SchemaInfo/5
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id}")]
        public async Task<ActionResult<SchemaInfo>> DeleteSchemaInfo(string id)
        {
            var schemaInfo = await _context.SchemaInfo.FindAsync(id);
            if (schemaInfo == null)
            {
                return NotFound();
            }

            _context.SchemaInfo.Remove(schemaInfo);
            await _context.SaveChangesAsync();

            return schemaInfo;
        }

        private bool SchemaInfoExists(string id)
        {
            return _context.SchemaInfo.Any(e => e.SchemaName == id);
        }
    }
}
