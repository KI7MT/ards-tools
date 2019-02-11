using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/StateCounty")]
    [ApiController]
    public class StateCountyController : ControllerBase
    {
        private readonly AdifContext _context;

        public StateCountyController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/StateCounty
        [HttpGet]
        public async Task<ActionResult<IEnumerable<StateCounty>>> GetStateCounty()
        {
            return await _context.StateCounty.ToListAsync();
        }

        // GET: api/StateCounty/5
        [HttpGet("{id}")]
        public async Task<ActionResult<StateCounty>> GetStateCounty(int id)
        {
            var stateCounty = await _context.StateCounty.FindAsync(id);

            if (stateCounty == null)
            {
                return NotFound();
            }

            return stateCounty;
        }

        // PUT: api/StateCounty/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutStateCounty(int id, StateCounty stateCounty)
        {
            if (id != stateCounty.Id)
            {
                return BadRequest();
            }

            _context.Entry(stateCounty).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!StateCountyExists(id))
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

        // POST: api/StateCounty
        [HttpPost]
        public async Task<ActionResult<StateCounty>> PostStateCounty(StateCounty stateCounty)
        {
            _context.StateCounty.Add(stateCounty);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetStateCounty", new { id = stateCounty.Id }, stateCounty);
        }

        // DELETE: api/StateCounty/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<StateCounty>> DeleteStateCounty(int id)
        {
            var stateCounty = await _context.StateCounty.FindAsync(id);
            if (stateCounty == null)
            {
                return NotFound();
            }

            _context.StateCounty.Remove(stateCounty);
            await _context.SaveChangesAsync();

            return stateCounty;
        }

        private bool StateCountyExists(int id)
        {
            return _context.StateCounty.Any(e => e.Id == id);
        }
    }
}
