//
//  ReceiptsViewController.swift
//  ExpressWash
//
//  Created by Bobby Keffury on 4/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ReceiptsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties

    let jobController = JobController()
    var jobs: [Job] = []

    // MARK: - Outlets

    @IBOutlet weak var emptyReceiptsView: UIView!
    @IBOutlet weak var receiptsTableView: UITableView!

    // MARK: - Views

    override func viewDidLoad() {
        super.viewDidLoad()

        getJobs()
        receiptsTableView.delegate = self
        receiptsTableView.dataSource = self
    }

    // MARK: - Methods

    private func getJobs() {
        guard let user = UserController.shared.sessionUser.user else { return }

        jobController.getUserJobs(user: user) { (jobRepresentations, error) in
            if let error = error {
                print("Error getting user's jobs: \(error)")
                return
            }

            guard let jobReps = jobRepresentations else { return }

            self.jobs = []

            for rep in jobReps {
                let job = Job(representation: rep)
                self.jobs.append(job)
            }

            DispatchQueue.main.async {
                self.receiptsTableView.reloadData()
            }
        }
    }

    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jobs.count == 0 {
            emptyReceiptsView.alpha = 1
            return jobs.count
        } else {
            emptyReceiptsView.alpha = 0
            return jobs.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "receiptCell",
                                                       for: indexPath) as? ReceiptTableViewCell else {
                                                        return UITableViewCell() }

        let job = jobs[indexPath.row]

        let firstName = job.washer!.user!.firstName
        let lastName = job.washer!.user!.lastName

        cell.washerName.text = firstName + lastName

        if let url = job.washer!.user!.profilePicture {
            cell.washerImage.image = UIImage.cached(from: url, defaultTitle: "person.circle")
        } else {
            cell.washerImage.image = UIImage(named: "person.circle")
        }

        cell.washerRating.text = "★ \(job.washer!.washerRating))"

        cell.dateLabel.text = DateFormatter.dateString(from: job.creationDate!)

        // Fix this when joel is through with his branch
        let timeTaken = DateFormatter.timeTaken(timeArrived: "TIME ARRIVED", timeCompleted: "TIME COMPLETED")

        cell.timeTakenLabel.text = "\(timeTaken) min"

        if let beforeString = job.photoBeforeJob {
            cell.beforeImageView.image = UIImage.cached(from: beforeString, defaultTitle: "MAKE THIS LOGO")
        }
        
        if let afterString = job.photoAfterJob {
            cell.afterImageView.image = UIImage.cached(from: afterString, defaultTitle: "MAKE THIS LOGO")
        }

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "washDetailSegue" {
            if let receiptDetailVC = segue.destination as? ReceiptDetailViewController,
                let indexPath = receiptsTableView.indexPathForSelectedRow {
                let job = jobs[indexPath.row]
                receiptDetailVC.job = job
            }
        }
    }
}
