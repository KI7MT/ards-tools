using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/QsoComplete")]
    [ApiController]
    public class QsoCompleteController : ControllerBase
    {
        private readonly AdifContext _context;

        public QsoCompleteController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/QsoComplete
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QsoComplete>>> GetQsoComplete()
        {
            return await _context.QsoComplete.ToListAsync();
        }

        // GET: api/QsoComplete/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QsoComplete>> GetQsoComplete(int id)
        {
            var qsoComplete = await _context.QsoComplete.FindAsync(id);

            if (qsoComplete == null)
            {
                return NotFound();
            }

            return qsoComplete;
        }

        // PUT: api/QsoComplete/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQsoComplete(int id, QsoComplete qsoComplete)
        {
            if (id != qsoComplete.Id)
            {
                return BadRequest();
            }

            _context.Entry(qsoComplete).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QsoCompleteExists(id))
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

        // POST: api/QsoComplete
        [HttpPost]
        public async Task<ActionResult<QsoComplete>> PostQsoComplete(QsoComplete qsoComplete)
        {
            _context.QsoComplete.Add(qsoComplete);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQsoComplete", new { id = qsoComplete.Id }, qsoComplete);
        }

        // DELETE: api/QsoComplete/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<QsoComplete>> DeleteQsoComplete(int id)
        {
            var qsoComplete = await _context.QsoComplete.FindAsync(id);
            if (qsoComplete == null)
            {
                return NotFound();
            }

            _context.QsoComplete.Remove(qsoComplete);
            await _context.SaveChangesAsync();

            return qsoComplete;
        }

        private bool QsoCompleteExists(int id)
        {
            return _context.QsoComplete.Any(e => e.Id == id);
        }
    }
}
