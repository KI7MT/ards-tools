using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/ModeDescription")]
    [ApiController]
    public class ModeDescriptionController : ControllerBase
    {
        private readonly AdifContext _context;

        public ModeDescriptionController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/ModeDescription
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ModeDescription>>> GetModeDescription()
        {
            return await _context.ModeDescription.ToListAsync();
        }

        // GET: api/ModeDescription/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ModeDescription>> GetModeDescription(int id)
        {
            var modeDescription = await _context.ModeDescription.FindAsync(id);

            if (modeDescription == null)
            {
                return NotFound();
            }

            return modeDescription;
        }

        // PUT: api/ModeDescription/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutModeDescription(int id, ModeDescription modeDescription)
        {
            if (id != modeDescription.Id)
            {
                return BadRequest();
            }

            _context.Entry(modeDescription).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ModeDescriptionExists(id))
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

        // POST: api/ModeDescription
        [HttpPost]
        public async Task<ActionResult<ModeDescription>> PostModeDescription(ModeDescription modeDescription)
        {
            _context.ModeDescription.Add(modeDescription);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetModeDescription", new { id = modeDescription.Id }, modeDescription);
        }

        // DELETE: api/ModeDescription/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<ModeDescription>> DeleteModeDescription(int id)
        {
            var modeDescription = await _context.ModeDescription.FindAsync(id);
            if (modeDescription == null)
            {
                return NotFound();
            }

            _context.ModeDescription.Remove(modeDescription);
            await _context.SaveChangesAsync();

            return modeDescription;
        }

        private bool ModeDescriptionExists(int id)
        {
            return _context.ModeDescription.Any(e => e.Id == id);
        }
    }
}
