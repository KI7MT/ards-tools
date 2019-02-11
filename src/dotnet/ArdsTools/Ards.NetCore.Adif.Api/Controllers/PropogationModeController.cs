using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/PropogationMode")]
    [ApiController]
    public class PropogationModeController : ControllerBase
    {
        private readonly AdifContext _context;

        public PropogationModeController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/PropogationMode
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PropogationMode>>> GetPropogationMode()
        {
            return await _context.PropogationMode.ToListAsync();
        }

        // GET: api/PropogationMode/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PropogationMode>> GetPropogationMode(int id)
        {
            var propogationMode = await _context.PropogationMode.FindAsync(id);

            if (propogationMode == null)
            {
                return NotFound();
            }

            return propogationMode;
        }

        // PUT: api/PropogationMode/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPropogationMode(int id, PropogationMode propogationMode)
        {
            if (id != propogationMode.Id)
            {
                return BadRequest();
            }

            _context.Entry(propogationMode).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PropogationModeExists(id))
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

        // POST: api/PropogationMode
        [HttpPost]
        public async Task<ActionResult<PropogationMode>> PostPropogationMode(PropogationMode propogationMode)
        {
            _context.PropogationMode.Add(propogationMode);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPropogationMode", new { id = propogationMode.Id }, propogationMode);
        }

        // DELETE: api/PropogationMode/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<PropogationMode>> DeletePropogationMode(int id)
        {
            var propogationMode = await _context.PropogationMode.FindAsync(id);
            if (propogationMode == null)
            {
                return NotFound();
            }

            _context.PropogationMode.Remove(propogationMode);
            await _context.SaveChangesAsync();

            return propogationMode;
        }

        private bool PropogationModeExists(int id)
        {
            return _context.PropogationMode.Any(e => e.Id == id);
        }
    }
}
