//
//  MainViewController.swift
//  blueTooth
//
//  Created by imac-1682 on 2023/8/22.
//

import UIKit
import CoreBluetooth


class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var LightValue: UILabel!
    
    // MARK: - Variables
    var connectPeripherals: [CBPeripheral] =  []
    var connectServices: [CBService]?
    var connectName: [String] = []
    var selectedIndexPath: IndexPath?

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BluetoothServices.shared.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - IBAction
    
}
// MARK: - Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectName.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.Service.text = "\(connectName[indexPath.row])"
        
        let checkmarkView = UIImageView(image: UIImage(systemName: "checkmark"))
        cell.accessoryView = nil
//
//        if cell.isSelected {
//            cell.accessoryView = checkmarkView
//
//        }
        if indexPath == selectedIndexPath {
            cell.accessoryView = checkmarkView
        } else {
            cell.accessoryView = nil
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let peripheral = connectPeripherals[indexPath.row]
        let selectedCell = tableView.cellForRow(at: indexPath)
        for cell in tableView.visibleCells {
            if cell != selectedCell {
                cell.accessoryView = nil
            }
        }
        let checkmarkView = UIImageView(image: UIImage(systemName: "checkmark"))
        selectedCell?.accessoryView = checkmarkView
        selectedCell?.isSelected = true
        BluetoothServices.shared.connectPeripheral(peripheral: peripheral)
    }
}

extension MainViewController: BluetoothServicesDelegate, CBPeripheralDelegate {
    
    func getBLEPeripherals(peripherals: [CBPeripheral]) {
        for i in peripherals {
            if let name = i.name, !connectName.contains(name) {
                connectName.append(name)
            }
        }
        for peripheral in peripherals {
            if !connectPeripherals.contains(peripheral){
                connectPeripherals.append(peripheral)
            }
        }
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
    }
    
    func getBlEPeripheralValue(value: UInt8) {
        DispatchQueue.main.async { [self] in
            LightValue.text = "\(value)"

        }
    }
}
// MARK: - Protocol


