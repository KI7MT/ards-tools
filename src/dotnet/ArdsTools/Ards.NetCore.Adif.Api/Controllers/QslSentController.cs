using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/QslSent")]
    [ApiController]
    public class QslSentController : ControllerBase
    {
        private readonly AdifContext _context;

        public QslSentController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/QslSent
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QslSent>>> GetQslSent()
        {
            return await _context.QslSent.ToListAsync();
        }

        // GET: api/QslSent/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QslSent>> GetQslSent(int id)
        {
            var qslSent = await _context.QslSent.FindAsync(id);

            if (qslSent == null)
            {
                return NotFound();
            }

            return qslSent;
        }

        // PUT: api/QslSent/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQslSent(int id, QslSent qslSent)
        {
            if (id != qslSent.Id)
            {
                return BadRequest();
            }

            _context.Entry(qslSent).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QslSentExists(id))
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

        // POST: api/QslSent
        [HttpPost]
        public async Task<ActionResult<QslSent>> PostQslSent(QslSent qslSent)
        {
            _context.QslSent.Add(qslSent);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQslSent", new { id = qslSent.Id }, qslSent);
        }

        // DELETE: api/QslSent/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<QslSent>> DeleteQslSent(int id)
        {
            var qslSent = await _context.QslSent.FindAsync(id);
            if (qslSent == null)
            {
                return NotFound();
            }

            _context.QslSent.Remove(qslSent);
            await _context.SaveChangesAsync();

            return qslSent;
        }

        private bool QslSentExists(int id)
        {
            return _context.QslSent.Any(e => e.Id == id);
        }
    }
}
